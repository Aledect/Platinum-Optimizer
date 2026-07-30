document.addEventListener('DOMContentLoaded', () => {
    // 1. Initialise Lucide Icons
    if (window.lucide) {
        window.lucide.createIcons();
    }

    // 2. Hide Page Transition Overlay
    const pageTransition = document.getElementById('page-transition');
    if (pageTransition) {
        setTimeout(() => {
            pageTransition.classList.remove('active');
            if (typeof initGridAnimation === 'function') {
                initGridAnimation('deep-space', false);
            }
        }, 120);
    }

    // 4. Horizontal Scroll & Drag Logic
    const viewport = document.querySelector('.gallery-viewport');
    const galleryItems = document.querySelector('.gallery-container');

    if (viewport && galleryItems) {
        viewport.addEventListener('wheel', (e) => {
            if (e.deltaY !== 0) {
                if (Math.abs(e.deltaY) > Math.abs(e.deltaX)) {
                    e.preventDefault();
                    viewport.scrollLeft += e.deltaY * 2.5;
                }
            }
        }, { passive: false });

        let isDown = false;
        let startX;
        let scrollLeft;

        viewport.addEventListener('mousedown', (e) => {
            isDown = true;
            viewport.classList.add('active');
            startX = e.pageX - viewport.offsetLeft;
            scrollLeft = viewport.scrollLeft;
        });

        viewport.addEventListener('mouseleave', () => {
            isDown = false;
            viewport.classList.remove('active');
        });

        viewport.addEventListener('mouseup', () => {
            isDown = false;
            viewport.classList.remove('active');
        });

        viewport.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - viewport.offsetLeft;
            const walk = (x - startX) * 2.5;
            viewport.scrollLeft = scrollLeft - walk;
        });
    }
});

// ============ MODAL LOGIC FOR STANDALONE PAGE (iOS 27 FLIP) ============

// Track the last clicked preview button for FLIP close
let _lastPreviewTrigger = null;

window.openPreview = function (src, titleKey) {
    const modal = document.getElementById('preview-modal');
    const modalImg = document.getElementById('modal-img');
    const modalTitle = document.getElementById('modal-title');
    const downloadLink = document.getElementById('modal-download-link');

    if (!modal || !modalImg) return;

    modalImg.src = src;

    // Handle translation
    if (modalTitle) {
        modalTitle.setAttribute('data-i18n', titleKey);
        if (typeof getAppContent === 'function' && typeof getNestedValue === 'function') {
            const content = getAppContent();
            const value = getNestedValue(content, titleKey);
            if (value) modalTitle.innerHTML = value;
        } else {
            modalTitle.textContent = titleKey;
        }
    }

    if (downloadLink) downloadLink.href = src;

    // Find the trigger button (the preview button that was clicked)
    const triggerBtn = event && event.currentTarget ? event.currentTarget : null;
    _lastPreviewTrigger = triggerBtn;

    // Find the wallpaper card that contains this button for FLIP source
    const triggerCard = triggerBtn ? triggerBtn.closest('.wallpaper-card') : null;

    if (triggerCard && typeof FlipEngine !== 'undefined') {
        // Use FlipEngine for iOS 27 FLIP animation from the card
        if (!triggerCard.id) {
            triggerCard.id = 'flip-wallpaper-' + Math.random().toString(36).substr(2, 9);
        }
        modal.dataset.triggerCardId = triggerCard.id;

        document.body.style.overflow = 'hidden';
        if (window.bgAnimation) window.bgAnimation.modalActive = true;

        // We adapt FlipEngine for this modal structure
        // First: capture card position
        var triggerData = FlipEngine.getExactTriggerData(triggerCard);
        var unTransformed = triggerData.rect;

        // Show modal instantly
        modal.style.transition = 'none';
        modal.style.opacity = '1';
        modal.classList.add('active');

        // Hide the modal content initially to position it
        var modalContent = modal.querySelector('.modal-content');
        if (modalContent) {
            modalContent.style.transition = 'none';
            modalContent.style.transform = 'scale(0.95)';
            modalContent.style.opacity = '0';
        }

        // Fade out the trigger card
        triggerCard.animate([
            { opacity: 1 },
            { opacity: 0.3 }
        ], {
            duration: 150,
            easing: 'ease-out',
            fill: 'forwards'
        });

        requestAnimationFrame(function () {
            // Animate modal content in with spring
            if (modalContent) {
                modalContent.animate([
                    { transform: 'scale(0.85)', opacity: 0 },
                    { transform: 'scale(1)', opacity: 1 }
                ], {
                    duration: 550,
                    easing: 'cubic-bezier(0.23, 1, 0.32, 1)',
                    fill: 'forwards'
                });
            }

            // Animate the image from card position
            var imgRect = modalImg.getBoundingClientRect();
            if (imgRect.width > 0 && unTransformed.width > 0) {
                var scaleX = unTransformed.width / imgRect.width;
                var scaleY = unTransformed.height / imgRect.height;
                var deltaX = (unTransformed.left + unTransformed.width / 2) - (imgRect.left + imgRect.width / 2);
                var deltaY = (unTransformed.top + unTransformed.height / 2) - (imgRect.top + imgRect.height / 2);

                var startTransform = 'translate(' + deltaX.toFixed(2) + 'px, ' + deltaY.toFixed(2) + 'px) ' + 
                                     triggerData.transformString + ' ' + 
                                     'scale(' + scaleX.toFixed(4) + ', ' + scaleY.toFixed(4) + ')';

                modalImg.animate([
                    {
                        transform: startTransform,
                        borderRadius: triggerData.borderRadius || '18px'
                    },
                    {
                        transform: 'translate(0px, 0px) scale(1)',
                        borderRadius: '2rem'
                    }
                ], {
                    duration: 600,
                    easing: 'cubic-bezier(0.23, 1, 0.32, 1)',
                    fill: 'forwards'
                });
            }
        });
    } else {
        // Fallback: simple active class
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        if (window.bgAnimation) window.bgAnimation.modalActive = true;
    }
};

window.closePreview = function () {
    const modal = document.getElementById('preview-modal');
    const modalImg = document.getElementById('modal-img');
    if (!modal) return;

    var triggerCardId = modal.dataset.triggerCardId;
    var triggerCard = triggerCardId ? document.getElementById(triggerCardId) : null;

    if (triggerCard && typeof FlipEngine !== 'undefined') {
        // Recalculate card position (may have scrolled)
        var triggerData = FlipEngine.getExactTriggerData(triggerCard);
        var unTransformed = triggerData.rect;
        var modalContent = modal.querySelector('.modal-content');

        // Animate modal content out
        if (modalContent) {
            modalContent.animate([
                { transform: 'scale(1)', opacity: 1 },
                { transform: 'scale(0.9)', opacity: 0 }
            ], {
                duration: 350,
                easing: 'cubic-bezier(0.32, 0.72, 0, 1)',
                fill: 'forwards'
            });
        }

        // Animate image back to card
        if (modalImg) {
            var imgRect = modalImg.getBoundingClientRect();
            if (imgRect.width > 0 && unTransformed.width > 0) {
                // Cancel any lingering animations
                if (modalImg.getAnimations) {
                    modalImg.getAnimations().forEach(function (a) { try { a.cancel(); } catch (e) { } });
                }

                var scaleX = unTransformed.width / imgRect.width;
                var scaleY = unTransformed.height / imgRect.height;
                var deltaX = (unTransformed.left + unTransformed.width / 2) - (imgRect.left + imgRect.width / 2);
                var deltaY = (unTransformed.top + unTransformed.height / 2) - (imgRect.top + imgRect.height / 2);

                var endTransform = 'translate(' + deltaX.toFixed(2) + 'px, ' + deltaY.toFixed(2) + 'px) ' + 
                                   triggerData.transformString + ' ' + 
                                   'scale(' + scaleX.toFixed(4) + ', ' + scaleY.toFixed(4) + ')';

                modalImg.animate([
                    {
                        transform: 'translate(0px, 0px) scale(1)',
                        borderRadius: '2rem'
                    },
                    {
                        transform: endTransform,
                        borderRadius: triggerData.borderRadius || '18px'
                    }
                ], {
                    duration: 450,
                    easing: 'cubic-bezier(0.32, 0.72, 0, 1)',
                    fill: 'forwards'
                });
            }
        }

        // Fade card back in
        triggerCard.animate([
            { opacity: 0.3 },
            { opacity: 0.7 }  // Original opacity
        ], {
            duration: 200,
            delay: 250,
            easing: 'ease-out',
            fill: 'forwards'
        });

        // Clean up after animation
        setTimeout(function () {
            modal.classList.remove('active');
            modal.style.opacity = '';
            modal.style.transition = '';

            if (modalContent) {
                modalContent.style.transform = '';
                modalContent.style.opacity = '';
                modalContent.style.transition = '';
            }
            if (modalImg && modalImg.getAnimations) {
                modalImg.getAnimations().forEach(function (a) { try { a.cancel(); } catch (e) { } });
            }
            if (modalImg) modalImg.style.transform = '';

            // Restore card opacity fully
            if (triggerCard && triggerCard.getAnimations) {
                triggerCard.getAnimations().forEach(function (a) { try { a.cancel(); } catch (e) { } });
            }
            if (triggerCard) triggerCard.style.opacity = '';

            document.body.style.overflow = '';
            if (window.bgAnimation) window.bgAnimation.modalActive = false;
            modal.dataset.triggerCardId = '';
        }, 460);
    } else {
        // Fallback
        modal.classList.remove('active');
        document.body.style.overflow = '';
        if (window.bgAnimation) window.bgAnimation.modalActive = false;
    }
};


window.goBack = function () {
    if (typeof window.navigateTo === 'function') {
        window.navigateTo('index.html');
    } else {
        const pageTransition = document.getElementById('page-transition');
        if (pageTransition) {
            pageTransition.classList.add('active');
            setTimeout(() => {
                window.location.href = 'index.html';
            }, 300);
        } else {
            window.location.href = 'index.html';
        }
    }
};
