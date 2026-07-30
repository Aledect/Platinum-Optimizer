/**
 * ============================================================
 *  FLIP ENGINE — iOS 27 Style Lightbox Animation (V2)
 *  Perfect 3D alignment using transform string concatenation.
 * ============================================================
 */

const FlipEngine = (function () {
    'use strict';

    const SPRING_OPEN = 'cubic-bezier(0.23, 1, 0.32, 1)';
    const SPRING_CLOSE = 'cubic-bezier(0.32, 0.72, 0, 1)';
    const SPRING_BORDER = 'cubic-bezier(0.34, 1.56, 0.64, 1)';
    const DURATION_OPEN = 600;   // ms
    const DURATION_CLOSE = 450;  // ms
    const DURATION_BORDER = 350; // ms

    let _activeAnimation = null;
    let _triggerSnapshot = null;

    function getMatrixTranslation(el) {
        const transform = getComputedStyle(el).transform;
        if (!transform || transform === 'none') return { tx: 0, ty: 0 };
        
        if (transform.startsWith('matrix3d')) {
            const values = transform.match(/matrix3d\((.+)\)/)[1].split(',').map(parseFloat);
            return { tx: values[12], ty: values[13] };
        } else if (transform.startsWith('matrix')) {
            const values = transform.match(/matrix\((.+)\)/)[1].split(',').map(parseFloat);
            return { tx: values[4], ty: values[5] };
        }
        return { tx: 0, ty: 0 };
    }

    function removeTranslations(transformStr) {
        if (!transformStr) return '';
        return transformStr
            .replace(/translate\([^)]+\)/gi, '')
            .replace(/translateX\([^)]+\)/gi, '')
            .replace(/translateY\([^)]+\)/gi, '')
            .replace(/translateZ\([^)]+\)/gi, '')
            .replace(/translate3d\([^)]+\)/gi, '')
            .trim();
    }

    /**
     * Legge la posizione e la stringa transform in modo esatto.
     */
    function getExactTriggerData(transformEl, measureEl) {
        if (!measureEl) measureEl = transformEl;
        const style = transformEl.style;
        const computed = getComputedStyle(transformEl);
        
        // Salviamo lo stato attuale del contenitore
        const originalTransform = style.transform || computed.transform;
        const originalTransition = style.transition;
        
        // Estraiamo la traslazione matematica esatta computata dal browser (pixel-perfect)
        const matrixTxTy = getMatrixTranslation(transformEl);
        
        // Rimuoviamo il transform temporaneamente per avere la griglia 2D piatta
        style.transition = 'none';
        style.transform = 'none';
        
        // Leggiamo le coordinate dell'elemento interno per calcolare la proporzione perfetta
        const unTransformedRect = measureEl.getBoundingClientRect();
        
        // Ripristiniamo il contenitore
        style.transform = originalTransform;
        style.transition = originalTransition;
        
        return {
            rect: unTransformedRect,
            transformString: originalTransform === 'none' ? '' : originalTransform,
            borderRadius: getComputedStyle(measureEl).borderRadius || '0px',
            matrixTx: matrixTxTy.tx,
            matrixTy: matrixTxTy.ty
        };
    }



    function findTriggerImage(trigger) {
        if (trigger.tagName === 'IMG') return trigger;
        return trigger.querySelector('img') || trigger;
    }

    function getContainedSize(imgEl, containerRect) {
        const natW = imgEl.naturalWidth || 1;
        const natH = imgEl.naturalHeight || 1;
        const imgRatio = natW / natH;
        const containerRatio = containerRect.width / containerRect.height;

        let renderW = containerRect.width;
        let renderH = containerRect.height;

        if (imgRatio > containerRatio) {
            renderH = containerRect.width / imgRatio;
        } else {
            renderW = containerRect.height * imgRatio;
        }

        return { width: renderW, height: renderH };
    }

    function getPerspective(el) {
        let current = el.parentElement;
        while (current && current !== document.body) {
            const p = getComputedStyle(current).perspective;
            if (p && p !== 'none') {
                return p;
            }
            current = current.parentElement;
        }
        return 'none';
    }

    function cancelActive() {
        if (_activeAnimation) {
            if (_activeAnimation.animations) {
                _activeAnimation.animations.forEach(function (a) {
                    try { a.cancel(); } catch (e) { }
                });
            }
            _activeAnimation = null;
        }
    }

    // ── Apertura ──────────────────────────────────────────────

    function animateOpen(trigger, lightboxImg, modal, options) {
        options = options || {};
        cancelActive();
        
        modal.dataset.isClosing = 'false';
        modal.style.pointerEvents = '';

        var animations = [];
        var backdrop = modal.querySelector('.modal-backdrop');
        var closeBtn = modal.querySelector('button');
        
        var navbar = document.getElementById('navbar');
        if (navbar) {
            navbar.style.transition = 'none';
            navbar.style.zIndex = '250';
        }

        // Troviamo l'immagine reale all'interno del trigger per usarla come misura esatta
        var triggerImgEl = findTriggerImage(trigger);

        // 1. Dati Esatti del Trigger basati sull'immagine interna
        var triggerData = getExactTriggerData(trigger, triggerImgEl);

        _triggerSnapshot = {
            triggerId: trigger.id || ('flip-trigger-' + Math.random().toString(36).substr(2, 9))
        };
        if (!trigger.id) trigger.id = _triggerSnapshot.triggerId;

        // Copiamo la prospettiva per non avere scatti sugli angoli 3D (foreshortening)
        var sourcePerspective = getPerspective(trigger);
        lightboxImg.parentElement.style.perspective = sourcePerspective;

        // 2. Dissolvi il trigger (scompare per non fare da doppione)
        var triggerFadeAnim = trigger.animate([
            { opacity: 1 },
            { opacity: 0 }
        ], {
            duration: 150,
            easing: 'ease-out',
            fill: 'forwards'
        });
        animations.push(triggerFadeAnim);
        trigger.style.pointerEvents = 'none';

        // 3. Prepara il modale
        modal.style.transition = 'none';
        modal.style.opacity = '1';
        modal.classList.remove('hidden', 'opacity-0');

        if (backdrop) { backdrop.style.transition = 'none'; backdrop.style.opacity = '0'; }
        if (closeBtn) { closeBtn.style.transition = 'none'; closeBtn.style.opacity = '0'; }

        lightboxImg.style.transition = 'none';
        lightboxImg.style.transform = 'none';
        lightboxImg.style.borderRadius = triggerData.borderRadius;

        // 4. Esegui FLIP
        requestAnimationFrame(function () {
            var screenRect = lightboxImg.getBoundingClientRect();
            var contained = getContainedSize(lightboxImg, screenRect);

            var unTransformed = triggerData.rect;
            var scaleX = unTransformed.width / contained.width;
            var scaleY = unTransformed.height / contained.height;
            
            var centerX_trigger = unTransformed.left + unTransformed.width / 2;
            var centerY_trigger = unTransformed.top + unTransformed.height / 2;
            var centerX_screen = screenRect.left + screenRect.width / 2;
            var centerY_screen = screenRect.top + screenRect.height / 2;
            
            // Decoppiamo le traslazioni della pagina (scroll parallax) dallo scale() per evitare errori di coordinate
            var cleanString = removeTranslations(triggerData.transformString);
            
            var deltaX = centerX_trigger - centerX_screen + triggerData.matrixTx;
            var deltaY = centerY_trigger - centerY_screen + triggerData.matrixTy;

            var startTransform = 
                'translate(' + deltaX.toFixed(2) + 'px, ' + deltaY.toFixed(2) + 'px) ' + 
                cleanString + ' ' + 
                'scale(' + scaleX.toFixed(4) + ', ' + scaleY.toFixed(4) + ')';

            modal.classList.add('modal-active');

            if (options.onStart) options.onStart();

            // Calcola il border-radius inversamente proporzionale per compensare lo scale()
            var targetRadiusNum = parseFloat(triggerData.borderRadius) || 32;
            var startBorderRadius = (targetRadiusNum / scaleX).toFixed(2) + 'px / ' + (targetRadiusNum / scaleY).toFixed(2) + 'px';

            // Animazione Immagine
            var imgAnim = lightboxImg.animate([
                {
                    transform: startTransform,
                    borderRadius: startBorderRadius
                },
                {
                    transform: 'translate(0px, 0px) scale(1)',
                    borderRadius: '16px'
                }
            ], {
                duration: DURATION_OPEN,
                easing: SPRING_OPEN,
                fill: 'forwards'
            });
            animations.push(imgAnim);

            // Animazione Backdrop
            if (backdrop) {
                animations.push(backdrop.animate([
                    { opacity: 0 }, { opacity: 1 }
                ], { duration: DURATION_OPEN, easing: 'ease-out', fill: 'forwards' }));
            }

            // Animazione Close Button
            if (closeBtn) {
                animations.push(closeBtn.animate([
                    { opacity: 0 }, { opacity: 1 }
                ], { duration: 300, delay: 200, easing: 'ease-out', fill: 'forwards' }));
            }

            _activeAnimation = { animations: animations };

            imgAnim.onfinish = function () {
                if (navbar) {
                    navbar.style.transition = '';
                    navbar.style.zIndex = '';
                }
                if (_triggerSnapshot && trigger.id === _triggerSnapshot.triggerId) {
                    trigger.style.opacity = '1';
                }
                lightboxImg.style.transform = 'translate(0px, 0px) scale(1)';
                lightboxImg.style.borderRadius = '16px';
                lightboxImg.style.border = 'none';
                lightboxImg.parentElement.style.perspective = '';
                if (options.onComplete) options.onComplete();
            };
        });

        return _triggerSnapshot.triggerId;
    }

    // ── Chiusura ──────────────────────────────────────────────

    function animateClose(trigger, lightboxImg, modal, options) {
        if (modal.dataset.isClosing === 'true') return;
        modal.dataset.isClosing = 'true';
        modal.style.pointerEvents = 'none';
        
        options = options || {};
        cancelActive();

        var animations = [];
        var backdrop = modal.querySelector('.modal-backdrop');
        var closeBtn = modal.querySelector('button');

        var navbar = document.getElementById('navbar');
        if (navbar) {
            navbar.style.transition = 'none';
            navbar.style.zIndex = '250';
        }

        modal.classList.remove('modal-active');

        // 1. Ricalcolo posizione trigger basato sull'immagine interna
        var triggerImgEl = findTriggerImage(trigger);
        var triggerData = getExactTriggerData(trigger, triggerImgEl);
        
        // Copiamo la prospettiva
        var sourcePerspective = getPerspective(trigger);
        lightboxImg.parentElement.style.perspective = sourcePerspective;
        
        var screenRect = lightboxImg.getBoundingClientRect();
        var contained = getContainedSize(lightboxImg, screenRect);

        var unTransformed = triggerData.rect;
        var scaleX = unTransformed.width / contained.width;
        var scaleY = unTransformed.height / contained.height;
        
        var centerX_trigger = unTransformed.left + unTransformed.width / 2;
        var centerY_trigger = unTransformed.top + unTransformed.height / 2;
        var centerX_screen = screenRect.left + screenRect.width / 2;
        var centerY_screen = screenRect.top + screenRect.height / 2;
        
        // Decoppiamo le traslazioni della pagina (scroll parallax) dallo scale() per evitare errori di coordinate
        var cleanString = removeTranslations(triggerData.transformString);
        
        var deltaX = centerX_trigger - centerX_screen + triggerData.matrixTx;
        var deltaY = centerY_trigger - centerY_screen + triggerData.matrixTy;

        var endTransform = 
            'translate(' + deltaX.toFixed(2) + 'px, ' + deltaY.toFixed(2) + 'px) ' + 
            cleanString + ' ' + 
            'scale(' + scaleX.toFixed(4) + ', ' + scaleY.toFixed(4) + ')';

        // Ripuliamo i fill-forwards pendenti
        if (lightboxImg.getAnimations) {
            lightboxImg.getAnimations().forEach(function (a) { try { a.cancel(); } catch(e){} });
        }
        
        lightboxImg.style.transition = 'none';
        lightboxImg.style.transform = 'translate(0px, 0px) scale(1)';
        lightboxImg.style.borderRadius = '16px';
        lightboxImg.style.boxSizing = 'border-box';
        lightboxImg.offsetHeight; // Force reflow

        // Calcola il border-radius inversamente proporzionale per compensare lo scale()
        var targetRadiusNum = parseFloat(triggerData.borderRadius) || 32;
        var endBorderRadius = (targetRadiusNum / scaleX).toFixed(2) + 'px / ' + (targetRadiusNum / scaleY).toFixed(2) + 'px';

        // Animazione Ritorno Immagine
        var imgAnim = lightboxImg.animate([
            {
                transform: 'translate(0px, 0px) scale(1)',
                borderRadius: '16px'
            },
            {
                transform: endTransform,
                borderRadius: endBorderRadius
            }
        ], {
            duration: DURATION_CLOSE,
            easing: SPRING_CLOSE,
            fill: 'forwards'
        });
        animations.push(imgAnim);

        // Animazione Backdrop
        if (backdrop) {
            animations.push(backdrop.animate([
                { opacity: getComputedStyle(backdrop).opacity || '1' }, { opacity: 0 }
            ], { duration: DURATION_CLOSE, easing: 'ease-in', fill: 'forwards' }));
        }

        // Animazione Close Button
        if (closeBtn) {
            animations.push(closeBtn.animate([
                { opacity: getComputedStyle(closeBtn).opacity || '1' }, { opacity: 0 }
            ], { duration: 150, easing: 'ease-in', fill: 'forwards' }));
        }

        // Dissolvenza Trigger in Entrata (il bordo originale riappare qui dolcemente alla fine)
        // Usiamo fill: 'both' così durante il delay l'opacità rimane 0 e non c'è il flash improvviso
        var triggerShowAnim = trigger.animate([
            { opacity: 0 }, { opacity: 1 }
        ], {
            duration: 250,
            delay: DURATION_CLOSE - 250, // Allineato per finire esattamente con DURATION_CLOSE
            easing: 'ease-out',
            fill: 'both' 
        });
        animations.push(triggerShowAnim);

        _activeAnimation = { animations: animations };

        // Cleanup
        imgAnim.onfinish = function () {
            animations.forEach(function (a) { try { a.cancel(); } catch(e){} });

            modal.classList.add('hidden');
            modal.style.opacity = '';
            lightboxImg.style.transform = '';
            lightboxImg.style.borderRadius = '';

            if (backdrop) backdrop.style.opacity = '';
            if (closeBtn) closeBtn.style.opacity = '';

            trigger.style.opacity = '1';
            trigger.style.pointerEvents = '';

            var remainingModals = document.querySelectorAll('.fixed:not(.hidden).modal-active');
            if (remainingModals.length === 0) {
                document.body.style.overflow = '';
                if (window.bgAnimation) window.bgAnimation.modalActive = false;
            }

            _activeAnimation = null;
            _triggerSnapshot = null;

            if (options.onComplete) options.onComplete();
        };
    }

    // ── Fallback ──────────────────────────────────────────────

    function animateOpenFallback(lightboxImg, modal, options) {
        options = options || {};
        var backdrop = modal.querySelector('.modal-backdrop');
        var closeBtn = modal.querySelector('button');

        modal.style.transition = 'none';
        modal.style.opacity = '1';
        modal.classList.remove('hidden', 'opacity-0');

        if (backdrop) { backdrop.style.transition = 'none'; backdrop.style.opacity = '0'; }
        if (closeBtn) { closeBtn.style.transition = 'none'; closeBtn.style.opacity = '0'; }

        lightboxImg.style.transition = 'none';
        lightboxImg.style.transform = 'scale(0.85)';
        lightboxImg.style.opacity = '0';

        requestAnimationFrame(function () {
            modal.classList.add('modal-active');

            lightboxImg.animate([
                { transform: 'scale(0.85)', opacity: 0 },
                { transform: 'scale(1)', opacity: 1 }
            ], { duration: DURATION_OPEN, easing: SPRING_OPEN, fill: 'forwards' });

            if (backdrop) backdrop.animate([{ opacity: 0 }, { opacity: 1 }], { duration: DURATION_OPEN, easing: 'ease-out', fill: 'forwards' });
            if (closeBtn) closeBtn.animate([{ opacity: 0 }, { opacity: 1 }], { duration: 300, delay: 200, easing: 'ease-out', fill: 'forwards' });

            if (options.onComplete) setTimeout(options.onComplete, DURATION_OPEN);
        });
    }

    function animateCloseFallback(lightboxImg, modal, options) {
        options = options || {};
        var backdrop = modal.querySelector('.modal-backdrop');
        var closeBtn = modal.querySelector('button');

        modal.classList.remove('modal-active');

        if (lightboxImg.getAnimations) {
            lightboxImg.getAnimations().forEach(function (a) { try { a.cancel(); } catch(e){} });
        }

        var imgAnim = lightboxImg.animate([
            { transform: 'scale(1)', opacity: 1 },
            { transform: 'scale(0.85)', opacity: 0 }
        ], { duration: DURATION_CLOSE, easing: 'ease-in', fill: 'forwards' });

        if (backdrop) backdrop.animate([{ opacity: 1 }, { opacity: 0 }], { duration: DURATION_CLOSE, easing: 'ease-in', fill: 'forwards' });
        if (closeBtn) closeBtn.animate([{ opacity: 1 }, { opacity: 0 }], { duration: 150, easing: 'ease-in', fill: 'forwards' });

        imgAnim.onfinish = function () {
            modal.dataset.isClosing = 'false';
            modal.style.pointerEvents = '';
            if (navbar) {
                navbar.style.transition = '';
                navbar.style.zIndex = '';
            }
            modal.classList.add('hidden');
            modal.style.opacity = '';
            lightboxImg.style.transform = '';
            lightboxImg.style.opacity = '';
            if (backdrop) backdrop.style.opacity = '';
            if (closeBtn) closeBtn.style.opacity = '';

            document.body.style.overflow = '';
            if (window.bgAnimation) window.bgAnimation.modalActive = false;

            if (options.onComplete) options.onComplete();
        };
    }

    return {
        animateOpen: animateOpen,
        animateClose: animateClose,
        animateOpenFallback: animateOpenFallback,
        animateCloseFallback: animateCloseFallback,
        getExactTriggerData: getExactTriggerData,
        cancelActive: cancelActive
    };

})();
