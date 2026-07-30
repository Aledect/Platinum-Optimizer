/**
 * Platinum+ Wiki — Interactivity and Navigation
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize Lucide icons
    if (window.lucide) {
        window.lucide.createIcons();
    }

    // --- SIDEBAR COLLAPSIBLE SECTIONS ---
    const groupHeaders = document.querySelectorAll('.group-header');
    
    groupHeaders.forEach(header => {
        header.addEventListener('click', () => {
            const group = header.parentElement;
            const ul = group.querySelector(':scope > ul');
            const isExpanding = !group.classList.contains('open');
            
            if (isExpanding) {
                // Opening
                group.classList.add('open');
                if (ul) {
                    ul.style.maxHeight = ul.scrollHeight + 'px';
                }
            } else {
                // Closing
                if (ul) {
                    // Set to current exact height first so animation has a starting point
                    ul.style.maxHeight = ul.scrollHeight + 'px';
                    
                    // Use requestAnimationFrame to let the browser apply the height before setting to 0
                    requestAnimationFrame(() => {
                        requestAnimationFrame(() => {
                            ul.style.maxHeight = '0px';
                        });
                    });
                }
                group.classList.remove('open');
            }
            
            // Update ARIA state
            header.setAttribute('aria-expanded', isExpanding);
            
            // Toggle arrow icon
            const arrow = header.querySelector('.arrow-icon');
            if (arrow) {
                arrow.setAttribute('data-lucide', isExpanding ? 'chevron-down' : 'chevron-right');
                window.lucide.createIcons({
                    attrs: { class: 'arrow-icon' },
                    name: isExpanding ? 'chevron-down' : 'chevron-right'
                });
            }
        });
    });

    // Clean up max-height after transition opens so nested elements can expand
    document.querySelectorAll('.tree-item-group > ul').forEach(ul => {
        ul.addEventListener('transitionend', (e) => {
            if (e.propertyName === 'max-height') {
                const group = ul.parentElement;
                if (group.classList.contains('open')) {
                    // Remove inline max-height so it can grow if children expand
                    ul.style.maxHeight = 'none';
                }
            }
        });
    });

    // Initialize already open groups
    document.querySelectorAll('.tree-item-group.open > ul').forEach(ul => {
        ul.style.maxHeight = 'none';
    });

    // --- DYNAMIC NAVIGATION & BREADCRUMB ---
    const navLinks = document.querySelectorAll('.sidebar-nav a');
    const wikiPages = document.querySelectorAll('.wiki-page');
    const breadcrumbCategory = document.getElementById('breadcrumb-category');
    const breadcrumbPage = document.getElementById('breadcrumb-page');
    const loader = document.getElementById('page-loader');
    const tocNavUl = document.querySelector('#toc-nav ul');

    // Helper to slugify text for IDs
    const slugify = (text) => {
        return text.toString().toLowerCase()
            .replace(/\s+/g, '-')           // Replace spaces with -
            .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
            .replace(/\-\-+/g, '-')         // Replace multiple - with single -
            .replace(/^-+/, '')             // Trim - from start of text
            .replace(/-+$/, '');            // Trim - from end of text
    };

    // --- TOC HIGHLIGHT ON SCROLL ---
    const tocHighlightObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const id = entry.target.id;
                const tocLinks = document.querySelectorAll('#toc-nav a');
                tocLinks.forEach(link => {
                    link.classList.toggle('active', link.getAttribute('href') === `#${id}`);
                });
            }
        });
    }, {
        rootMargin: '-50px 0px -80% 0px',
        threshold: 0
    });

    // Function to generate TOC based on headings of active page
    const generateTOC = (activePage) => {
        if (!tocNavUl) return;
        tocNavUl.innerHTML = '';
        
        // Disconnect old observations
        tocHighlightObserver.disconnect();
        
        // Search for the article title (H1), section subheadings (H2), and step subheadings (H3)
        // Filter out headings that are inside hidden tab-content panels
        const allHeadings = activePage.querySelectorAll('h1.article-title, h2, h3');
        const headings = Array.from(allHeadings).filter(heading => {
            let parent = heading.parentElement;
            while (parent && parent !== activePage) {
                // Skip headings inside inactive tab-content panels
                if (parent.classList.contains('tab-content') && !parent.classList.contains('active')) {
                    return false;
                }
                // Skip headings inside elements explicitly hidden with display:none
                if (parent.style && parent.style.display === 'none') {
                    return false;
                }
                parent = parent.parentElement;
            }
            return true;
        });
        
        const tocContainer = document.querySelector('.wiki-toc');
        // Always display the TOC to keep layout consistent, unless on smaller screens
        if (tocContainer && window.innerWidth > 1100) {
            tocContainer.style.display = 'block';
        } else if (tocContainer && window.innerWidth <= 1100) {
            tocContainer.style.display = '';
        }

        if (headings.length === 0) {
            return;
        }

        const usedIds = new Set();

        headings.forEach(heading => {
            // Ensure heading has a UNIQUE ID
            if (!heading.id) {
                let baseId = slugify(heading.textContent);
                let uniqueId = baseId;
                let counter = 1;
                // Append a counter suffix if this ID is already taken
                while (usedIds.has(uniqueId)) {
                    uniqueId = `${baseId}-${counter}`;
                    counter++;
                }
                heading.id = uniqueId;
            }
            // Track this ID as used (whether pre-existing or newly generated)
            usedIds.add(heading.id);

            const li = document.createElement('li');
            const a = document.createElement('a');
            a.href = `#${heading.id}`;
            
            // Clean up text if it contains spans (like numbers)
            let text = heading.textContent;
            a.textContent = text;
            
            // Indent H2 and H3 elements
            if (heading.tagName.toLowerCase() === 'h2') {
                li.style.paddingLeft = '0.75rem';
            } else if (heading.tagName.toLowerCase() === 'h3') {
                li.style.paddingLeft = '1.5rem';
                a.style.fontSize = '0.85rem';
            }

            a.addEventListener('click', (e) => {
                e.preventDefault();
                const target = document.getElementById(heading.id);
                if (target) {
                    const offset = 100; // Header height + padding
                    const bodyRect = document.body.getBoundingClientRect().top;
                    const elementRect = target.getBoundingClientRect().top;
                    const elementPosition = elementRect - bodyRect;
                    const offsetPosition = elementPosition - offset;

                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                }
            });

            li.appendChild(a);
            tocNavUl.appendChild(li);
            
            // Observe this heading for highlighting
            tocHighlightObserver.observe(heading);
        });

        // Set first TOC link as active by default
        const firstTocLink = tocNavUl.querySelector('a');
        if (firstTocLink) {
            firstTocLink.classList.add('active');
        }
    };

    // --- TEXT HIGHLIGHTING ---
    const highlightTextInElement = (element, query) => {
        clearSearchHighlights();
        if (!query) return;

        const nodesToReplace = [];
        const lowerQuery = query.toLowerCase();

        // Also check siblings until the next section
        const elementsToSearch = [element];
        let nextNode = element.nextElementSibling;
        while (nextNode && !nextNode.matches('h1, h2, h3, .step-card')) {
            elementsToSearch.push(nextNode);
            nextNode = nextNode.nextElementSibling;
        }

        elementsToSearch.forEach(el => {
            const elWalker = document.createTreeWalker(el, NodeFilter.SHOW_TEXT, null, false);
            let n;
            while (n = elWalker.nextNode()) {
                if (n.nodeValue && n.nodeValue.toLowerCase().includes(lowerQuery) && n.parentElement && n.parentElement.tagName !== 'MARK') {
                    nodesToReplace.push(n);
                }
            }
        });

        nodesToReplace.forEach(textNode => {
            // Escape query for regex
            const escapedQuery = query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
            const regex = new RegExp(`(${escapedQuery})`, 'gi');
            const newHTML = textNode.nodeValue.replace(regex, '<mark class="page-search-highlight">$1</mark>');
            if (newHTML !== textNode.nodeValue) {
                const span = document.createElement('span');
                span.innerHTML = newHTML;
                while(span.firstChild) {
                    textNode.parentNode.insertBefore(span.firstChild, textNode);
                }
                textNode.parentNode.removeChild(textNode);
            }
        });
    };

    const clearSearchHighlights = () => {
        const highlights = document.querySelectorAll('mark.page-search-highlight');
        highlights.forEach(mark => {
            const parent = mark.parentNode;
            if (parent) {
                parent.replaceChild(document.createTextNode(mark.textContent), mark);
                parent.normalize();
            }
        });
    };

    document.addEventListener('click', (e) => {
        if (!e.target.closest('.search-wrapper') && !e.target.closest('mark.page-search-highlight')) {
            clearSearchHighlights();
        }
    });

    // Navigation Click Handler
    const navigateToPage = (pageId, category, pageName, linkElement, sectionId = null, searchQuery = null) => {
        if (!pageId) return;

        // Update active link state
        navLinks.forEach(l => l.classList.remove('active'));
        let targetLink = linkElement;
        if (!targetLink) {
            targetLink = document.querySelector(`.sidebar-nav a[data-page="${pageId}"]`);
        }
        
        if (targetLink) {
            targetLink.classList.add('active');
            
            // Auto-expand parent groups in the sidebar
            let parent = targetLink.parentElement;
            let lucideIconsToUpdate = false;
            while (parent && !parent.classList.contains('sidebar-nav')) {
                if (parent.classList.contains('tree-item-group')) {
                    if (!parent.classList.contains('open')) {
                        parent.classList.add('open');
                        const ul = parent.querySelector(':scope > ul');
                        if (ul) ul.style.maxHeight = 'none';
                        
                        // Find header to update ARIA state and arrow icon
                        const header = parent.querySelector(':scope > .group-header');
                        if (header) {
                            header.setAttribute('aria-expanded', 'true');
                            const arrow = header.querySelector('.arrow-icon');
                            if (arrow) {
                                arrow.setAttribute('data-lucide', 'chevron-down');
                                lucideIconsToUpdate = true;
                            }
                        }
                    }
                }
                parent = parent.parentElement;
            }
            if (lucideIconsToUpdate && window.lucide) {
                window.lucide.createIcons({
                    attrs: { class: 'arrow-icon' }
                });
            }

        }

        // Close doc panel if open
        const docPanel = document.getElementById('contextual-doc-panel');
        if (docPanel && docPanel.classList.contains('open')) {
            docPanel.classList.remove('open');
            document.body.classList.remove('doc-panel-active');
        }

        // Hide current content
        const currentActive = document.querySelector('.wiki-page.active');
        const tocNav = document.getElementById('toc-nav');
        const tocHeader = document.querySelector('.toc-header');

        if (currentActive) {
            currentActive.classList.remove('page-fade-in');
            currentActive.style.opacity = '0';
        }
        if (tocNav) {
            tocNav.classList.remove('page-fade-in');
            tocNav.style.opacity = '0';
        }
        if (tocHeader) {
            tocHeader.classList.remove('page-fade-in');
            tocHeader.style.opacity = '0';
        }
        
        loader.style.display = 'block';

        // Unified Transition Timeout
        setTimeout(() => {
            loader.style.display = 'none';
            
            // Update Breadcrumb Text Instantly (No Animation)
            if (breadcrumbCategory) breadcrumbCategory.textContent = category;
            
            if (breadcrumbPage) {
                // Strip numbers like "1.1 " from the page name for breadcrumb
                const cleanPageName = pageName.replace(/^\d+\.\d+\s+/, '');
                breadcrumbPage.textContent = cleanPageName;
            }

            // Switch pages
            wikiPages.forEach(page => {
                page.classList.remove('active');
                page.classList.remove('page-fade-in');
            });
            
            const targetPage = document.getElementById(`page-${pageId}`);
            if (targetPage) {
                targetPage.classList.add('active');
                sessionStorage.setItem('wiki_last_page', pageId);

                const isRefresh = sessionStorage.getItem('wiki_is_refresh') === 'true';
                const savedY = sessionStorage.getItem('wiki_scroll_pos');

                // Scroll logic
                if (sectionId) {
                    const sectionEl = document.getElementById(sectionId);
                    if (sectionEl) {
                        const offset = 100;
                        const bodyRect = document.body.getBoundingClientRect().top;
                        const elementRect = sectionEl.getBoundingClientRect().top;
                        const offsetPosition = (elementRect - bodyRect) - offset;
                        window.scrollTo({ top: offsetPosition, behavior: 'smooth' });

                        if (searchQuery) {
                            highlightTextInElement(sectionEl, searchQuery);
                        }
                    } else if (isRefresh && savedY !== null) {
                        window.scrollTo({ top: parseInt(savedY, 10), behavior: 'instant' });
                        sessionStorage.removeItem('wiki_is_refresh');
                    } else {
                        window.scrollTo({ top: 0, behavior: 'auto' });
                    }
                } else if (isRefresh && savedY !== null) {
                    window.scrollTo({ top: parseInt(savedY, 10), behavior: 'instant' });
                    sessionStorage.removeItem('wiki_is_refresh');
                } else {
                    window.scrollTo({ top: 0, behavior: 'auto' });
                }

                // Re-generate TOC for new page
                generateTOC(targetPage);

                // Synchronized Animation: Apply same class to both content and TOC
                requestAnimationFrame(() => {
                    targetPage.classList.add('page-fade-in');
                    if (tocNav) tocNav.classList.add('page-fade-in');
                    if (tocHeader) tocHeader.classList.add('page-fade-in');
                    
                    const reveals = targetPage.querySelectorAll('.reveal');
                    reveals.forEach(el => el.classList.add('active'));
                });
            }
            
            // Close sidebar on mobile
            if (window.innerWidth < 768) {
                const sidebar = document.getElementById('wiki-sidebar');
                if (sidebar) {
                    sidebar.classList.remove('mobile-open');
                    window.lucide.createIcons();
                }
            }
        }, 150);
    };

    // --- ROUTER INTEGRATION: Listen for wiki-navigate events ---
    document.addEventListener('wiki-navigate', function(event) {
        const { pageId, category, title, sectionId, searchQuery } = event.detail;
        // Find the corresponding sidebar link for active state
        const linkElement = document.querySelector(`.sidebar-nav a[data-page="${pageId}"]`);
        navigateToPage(pageId, category, title, linkElement, sectionId, searchQuery);
    });

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const pageId = link.getAttribute('data-page');
            const category = link.getAttribute('data-category');
            const pageName = link.textContent;
            navigateToPage(pageId, category, pageName, link);
        });
    });



    // --- SCROLL REVEAL ANIMATIONS (For manual scroll) ---
    const triggerReveal = (container = document) => {
        const reveals = container.querySelectorAll('.reveal');
        
        const revealObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('active');
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        reveals.forEach(el => {
            revealObserver.observe(el);
        });
    };

    // Initial sidebar width adjustment on page load
    const initialSidebarWidthSetup = () => {
        const activeLink = document.querySelector('.sidebar-nav a.active');
        if (activeLink) {
            const category = activeLink.getAttribute('data-category');
            if (category === 'Optimization') {
                // Immediate update without delay
                updateSidebarWidth();
            }
        }
    };

    // Call initial setup immediately when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initialSidebarWidthSetup);
    } else {
        initialSidebarWidthSetup();
    }

    // Initial setup
    const initialPage = document.querySelector('.wiki-page.active');
    if (initialPage) {
        initialPage.classList.add('page-fade-in');
        const tocNav = document.getElementById('toc-nav');
        const tocHeader = document.querySelector('.toc-header');
        if (tocNav) tocNav.classList.add('page-fade-in');
        if (tocHeader) tocHeader.classList.add('page-fade-in');

        const initialReveals = initialPage.querySelectorAll('.reveal');
        initialReveals.forEach(el => el.classList.add('active'));
        
        generateTOC(initialPage);
    }
    triggerReveal();

    // --- UNIVERSAL SEARCH BAR ---
    const searchInput = document.getElementById('wiki-search');
    const searchResults = document.getElementById('search-results');
    let searchIndex = [];

    // Build Search Index
    const buildSearchIndex = () => {
        wikiPages.forEach(page => {
            const id = page.id.replace('page-', '');
            // Find corresponding link to get clean title and category
            const link = document.querySelector(`.sidebar-nav a[data-page="${id}"]`);
            if (!link) return;

            const category = link.getAttribute('data-category');
            const titleWithNumber = link.textContent;
            const cleanTitle = titleWithNumber.replace(/^\d+\.\d+\s+/, '');

            // Get category icon
            let iconHTML = '<i data-lucide="file-text"></i>';
            const groupItem = link.closest('.tree-item-group');
            if (groupItem) {
                const iconElement = groupItem.querySelector('.item-icon');
                if (iconElement) {
                    iconHTML = iconElement.outerHTML;
                }
            }

            // Exclude metadata and placeholders
            const meta = page.querySelector('.article-meta');
            const placeholders = page.querySelectorAll('.wiki-placeholder-img');

            const isExcluded = (node) => {
                if (meta && meta.contains(node)) return true;
                for (let i = 0; i < placeholders.length; i++) {
                    if (placeholders[i].contains(node)) return true;
                }
                return false;
            };

            const sections = page.querySelectorAll('h1, h2, h3, .step-card');
            
            if (sections.length === 0) {
                let contentText = page.textContent || page.innerText;
                contentText = contentText.replace(/\s+/g, ' ').trim();
                searchIndex.push({
                    id: id,
                    sectionId: null,
                    title: cleanTitle,
                    titleWithNumber: titleWithNumber,
                    category: category,
                    content: contentText,
                    linkElement: link,
                    iconHTML: iconHTML
                });
                return;
            }

            sections.forEach((section, index) => {
                if (isExcluded(section)) return;

                if (!section.id) {
                    section.id = `sec-${id}-${index}`;
                }
                
                let contentText = section.textContent + ' ';
                let nextNode = section.nextElementSibling;
                while (nextNode && !nextNode.matches('h1, h2, h3, .step-card')) {
                    if (!isExcluded(nextNode)) {
                        contentText += (nextNode.textContent || nextNode.innerText) + ' ';
                    }
                    nextNode = nextNode.nextElementSibling;
                }
                
                contentText = contentText.replace(/\s+/g, ' ').trim();

                let sectionTitle = section.textContent.trim();
                if (sectionTitle.length > 60) {
                    sectionTitle = sectionTitle.substring(0, 60) + '...';
                }

                let displayTitle = titleWithNumber;
                if (section.tagName !== 'H1' && sectionTitle && !titleWithNumber.includes(sectionTitle)) {
                    displayTitle = `${titleWithNumber} — ${sectionTitle}`;
                }

                searchIndex.push({
                    id: id,
                    sectionId: section.id,
                    title: cleanTitle + ' ' + sectionTitle,
                    titleWithNumber: displayTitle,
                    category: category,
                    content: contentText,
                    linkElement: link,
                    iconHTML: iconHTML
                });
            });
        });
    };

    // Build index once on load
    buildSearchIndex();

    if (searchInput && searchResults) {
        let searchTimeout;

        searchInput.addEventListener('input', (e) => {
            clearTimeout(searchTimeout);
            const query = e.target.value.toLowerCase().trim();

            if (query.length < 2) {
                searchResults.classList.remove('active');
                return;
            }

            searchTimeout = setTimeout(() => {
                const results = searchIndex.filter(item => 
                    item.title.toLowerCase().includes(query) || 
                    item.content.toLowerCase().includes(query)
                );

                renderSearchResults(results, query);
            }, 150); // Debounce
        });

        const renderSearchResults = (results, query) => {
            searchResults.innerHTML = '';
            
            if (results.length === 0) {
                searchResults.innerHTML = '<div class="search-empty">No results found for "'+query+'"</div>';
                searchResults.classList.add('active');
                return;
            }

            // Group results by category
            const groupedResults = results.reduce((acc, item) => {
                if (!acc[item.category]) acc[item.category] = [];
                acc[item.category].push(item);
                return acc;
            }, {});

            for (const [category, items] of Object.entries(groupedResults)) {
                const groupDiv = document.createElement('div');
                groupDiv.className = 'search-result-group';
                
                const header = document.createElement('div');
                header.className = 'search-result-header';
                header.textContent = category;
                groupDiv.appendChild(header);

                items.forEach(item => {
                    const resultItem = document.createElement('a');
                    resultItem.className = 'search-result-item';
                    
                    // Create context excerpt with highlight
                    let excerpt = '';
                    const contentLower = item.content.toLowerCase();
                    const matchIndex = contentLower.indexOf(query);
                    
                    if (matchIndex !== -1) {
                        const start = Math.max(0, matchIndex - 30);
                        const end = Math.min(item.content.length, matchIndex + query.length + 30);
                        let context = item.content.substring(start, end);
                        
                        if (start > 0) context = '...' + context;
                        if (end < item.content.length) context = context + '...';
                        
                        // Highlight the query
                        const highlightRegex = new RegExp(`(${query})`, 'gi');
                        excerpt = context.replace(highlightRegex, '<mark class="search-highlight">$1</mark>');
                    } else if (item.title.toLowerCase().includes(query)) {
                        excerpt = "Match found in title.";
                    }

                    resultItem.innerHTML = `
                        <div class="search-result-title">
                            ${item.iconHTML}
                            ${item.titleWithNumber}
                        </div>
                        <div class="search-result-excerpt">${excerpt}</div>
                    `;

                    // Click handler — use router for URL update
                    resultItem.addEventListener('click', (e) => {
                        e.preventDefault();
                        // Navigate via router to update URL
                        if (window.WikiRouter) {
                            window.WikiRouter.navigateToPage(item.id, item.sectionId, query);
                        } else {
                            navigateToPage(item.id, item.category, item.titleWithNumber, item.linkElement, item.sectionId, query);
                        }
                        searchResults.classList.remove('active');
                        searchInput.value = '';
                        searchInput.blur();
                    });

                    groupDiv.appendChild(resultItem);
                });

                searchResults.appendChild(groupDiv);
            }

            window.lucide.createIcons();
            searchResults.classList.add('active');
        };

        // Close search when clicking outside
        document.addEventListener('click', (e) => {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.classList.remove('active');
            }
        });

        // Close search on escape
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                searchResults.classList.remove('active');
                searchInput.blur();
            }
            if (e.key === '/' && document.activeElement !== searchInput) {
                e.preventDefault();
                searchInput.focus();
            }
        });
    }

    // --- COPY CODE BUTTONS ---
    const initializeCopyButtons = () => {
        const copyButtons = document.querySelectorAll('.copy-btn');
        copyButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const pre = btn.closest('.wiki-code-block').querySelector('pre code');
                navigator.clipboard.writeText(pre.textContent).then(() => {
                    const originalContent = btn.innerHTML;
                    btn.innerHTML = '<i data-lucide="check"></i> Copied!';
                    window.lucide.createIcons();
                    
                    setTimeout(() => {
                        btn.innerHTML = originalContent;
                        window.lucide.createIcons();
                    }, 2000);
                });
            });
        });
    };

    initializeCopyButtons();

    // --- INTERACTIVE TABS SWITCHER ---
    document.addEventListener('click', (e) => {
        const tabBtn = e.target.closest('.tab-btn');
        if (tabBtn) {
            const tabsContainer = tabBtn.closest('.wiki-tabs');
            if (tabsContainer) {
                const tabId = tabBtn.getAttribute('data-tab');
                
                // Deactivate all buttons in this container
                tabsContainer.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
                // Deactivate all tab contents in this container
                tabsContainer.querySelectorAll('.tab-content').forEach(pane => pane.classList.remove('active'));
                
                // Activate clicked button
                tabBtn.classList.add('active');
                // Activate target content pane
                const targetPane = tabsContainer.querySelector(`#tab-pane-${tabId}`);
                if (targetPane) {
                    targetPane.classList.add('active');
                }
                
                // Regenerate TOC since the visible headings changed
                const currentPage = document.querySelector('.wiki-page.active');
                if (currentPage) {
                    generateTOC(currentPage);
                }
                
                // If Lucide is available, recreate icons in the newly active content
                if (window.lucide) {
                    window.lucide.createIcons();
                }
            }
        }
    });

    // --- CUSTOM LANGUAGE SELECTOR SYNC & AUTO-DETECT ---

    const customLangSelector = document.getElementById('custom-lang-selector');
    const langWrapper = document.querySelector('.custom-lang-wrapper');
    const langBtn = document.getElementById('lang-selector-btn');
    const langMenu = document.getElementById('lang-dropdown-menu');
    const langDisplayText = document.getElementById('lang-display-text');

    if (customLangSelector && langWrapper) {
        // Build custom dropdown menu
        Array.from(customLangSelector.children).forEach(child => {
            if (child.tagName.toLowerCase() === 'optgroup') {
                const groupLabel = document.createElement('div');
                groupLabel.className = 'lang-group-label';
                groupLabel.textContent = child.label;
                langMenu.appendChild(groupLabel);

                Array.from(child.children).forEach(option => {
                    const optDiv = document.createElement('div');
                    optDiv.className = 'lang-option';
                    optDiv.dataset.value = option.value;
                    optDiv.textContent = option.textContent;
                    langMenu.appendChild(optDiv);
                });
            } else if (child.tagName.toLowerCase() === 'option') {
                const optDiv = document.createElement('div');
                optDiv.className = 'lang-option';
                optDiv.dataset.value = child.value;
                optDiv.textContent = child.textContent;
                langMenu.appendChild(optDiv);
            }
        });

        // Toggle menu
        langBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            langWrapper.classList.toggle('active');
        });

        // Close on click outside
        document.addEventListener('click', (e) => {
            if (!langWrapper.contains(e.target)) {
                langWrapper.classList.remove('active');
            }
        });

        // Update UI when native select changes
        const updateCustomUI = () => {
            const val = customLangSelector.value;
            const selectedOpt = customLangSelector.options[customLangSelector.selectedIndex];
            if (selectedOpt) {
                langDisplayText.textContent = selectedOpt.textContent;
            }
            langMenu.querySelectorAll('.lang-option').forEach(opt => {
                opt.classList.toggle('selected', opt.dataset.value === val);
            });
        };

        // Handle option click
        langMenu.addEventListener('click', (e) => {
            const optDiv = e.target.closest('.lang-option');
            if (optDiv) {
                const val = optDiv.dataset.value;
                customLangSelector.value = val;
                customLangSelector.dispatchEvent(new Event('change'));
                langWrapper.classList.remove('active');
            }
        });

        const setGoogleTransCookie = (lang) => {
            const domain = window.location.hostname;
            document.cookie = "googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            document.cookie = "googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=" + domain + ";";
            document.cookie = "googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=" + window.location.pathname + ";";
            
            if (lang && lang !== 'en') {
                document.cookie = `googtrans=/en/${lang}; path=/;`;
                if (domain && domain !== 'localhost' && !domain.includes('127.0.0.1')) {
                    document.cookie = `googtrans=/en/${lang}; path=/; domain=${domain};`;
                }
            }
        };

        // 1. Sync User Choice -> Google Translate
        customLangSelector.addEventListener('change', (e) => {
            const lang = e.target.value;
            updateCustomUI();
            setGoogleTransCookie(lang);

            const triggerTranslation = () => {
                const gCombo = document.querySelector('.goog-te-combo');

                if (lang === 'en') {
                    // DEACTIVATE TRANSLATION
                    document.documentElement.classList.remove('translated-ltr', 'translated-rtl');
                    
                    if (gCombo) {
                        gCombo.selectedIndex = 0;
                        gCombo.value = '';
                        gCombo.dispatchEvent(new Event('change'));
                    }

                    // Try clicking any restore buttons in Google Translate frames
                    document.querySelectorAll('iframe.goog-te-banner-frame, iframe.skiptranslate, iframe[id^=":"]').forEach(iframe => {
                        try {
                            const doc = iframe.contentWindow?.document || iframe.contentDocument;
                            if (doc) {
                                const btn = doc.querySelector('button[id*="restore"], .goog-close-link, #\\:1\\.restore');
                                if (btn) btn.click();
                            }
                        } catch (err) {}
                    });

                    return true;
                } else {
                    // ACTIVATE TRANSLATION
                    if (gCombo) {
                        gCombo.value = lang;
                        gCombo.dispatchEvent(new Event('change'));
                        return true;
                    }
                }
                return false;
            };

            if (!triggerTranslation()) {
                let attempts = 0;
                const retry = setInterval(() => {
                    if (triggerTranslation() || ++attempts > 20) clearInterval(retry);
                }, 250);
            }
        });

        // Hide any injected Google Translate top banner iframes
        setInterval(() => {
            document.querySelectorAll('.goog-te-banner-frame, iframe.skiptranslate, iframe[id^=":"]').forEach(iframe => {
                iframe.style.display = 'none';
                iframe.style.visibility = 'hidden';
            });
            if (document.body.style.top !== '0px' && document.body.style.top !== '') {
                document.body.style.top = '0px';
            }
        }, 500);

        // 3. Auto-detect browser language on first ever visit
        const getCookieLang = () => {
            const m = document.cookie.match(/(^|;)\s*googtrans=([^;]*)/);
            if (m) { const p = m[2].split('/'); return p[p.length - 1]; }
            return null;
        };

        const cookieLang = getCookieLang();
        if (cookieLang && cookieLang !== 'en') {
            // Restore previous choice
            const optExists = [...customLangSelector.options].some(o => o.value === cookieLang);
            if (optExists) {
                customLangSelector.value = cookieLang;
                updateCustomUI();
            }
        } else if (!cookieLang) {
            // First visit detect
            const browserLang = navigator.language.split('-')[0];
            const optExists = [...customLangSelector.options].some(o => o.value === browserLang);
            
            if (browserLang !== 'en' && optExists) {
                customLangSelector.value = browserLang;
                updateCustomUI();
                let attempts = 0;
                const autoSet = setInterval(() => {
                    const googleSelect = document.querySelector('.goog-te-combo');
                    if (googleSelect) {
                        googleSelect.value = browserLang;
                        googleSelect.dispatchEvent(new Event('change'));
                        clearInterval(autoSet);
                    }
                    if (++attempts > 40) clearInterval(autoSet);
                }, 250);
            }
        } else {
            // Default UI update (e.g. English)
            updateCustomUI();
        }
    }

    // --- CONTEXTUAL DOCUMENTATION PANEL ---
    const initContextualDocs = () => {
        const docBtns = document.querySelectorAll('.doc-btn');
        const panel = document.getElementById('contextual-doc-panel');
        const closeBtn = document.getElementById('close-doc-panel');
        const contentArea = document.getElementById('doc-panel-content');

        if (!panel) return;

        const openPanel = (targetId) => {
            const sourceElement = document.getElementById(targetId);
            if (sourceElement) {
                contentArea.innerHTML = sourceElement.innerHTML;
            } else {
                contentArea.innerHTML = '<p>Documentazione non trovata.</p>';
            }
            panel.classList.add('open');
            document.body.classList.add('doc-panel-active');
            
            // Re-initialize Lucide icons in case the injected content has icons
            if (window.lucide) {
                window.lucide.createIcons();
            }
        };

        const closePanel = () => {
            panel.classList.remove('open');
            document.body.classList.remove('doc-panel-active');
        };

        docBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                const target = btn.getAttribute('data-doc-target');
                if (target) {
                    openPanel(target);
                }
            });
        });

        if (closeBtn) closeBtn.addEventListener('click', closePanel);
    };

    // Continuous Scroll Position & Refresh State Tracking
    window.addEventListener('scroll', () => {
        sessionStorage.setItem('wiki_scroll_pos', window.scrollY.toString());
    }, { passive: true });

    window.addEventListener('beforeunload', () => {
        sessionStorage.setItem('wiki_scroll_pos', window.scrollY.toString());
        sessionStorage.setItem('wiki_is_refresh', 'true');
    });

    initContextualDocs();

    // --- SECTION 6 SIDEBAR RESIZE ANIMATION & SMART STATE MEMORY ---
    // Removed per user request - sidebar will use fixed CSS width instead
});