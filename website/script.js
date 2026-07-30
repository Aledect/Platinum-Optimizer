// ============ CONTENT (ENGLISH) ============
const APP_CONTENT = {
    nav: {
        home: "Home",
        about: "What is",
        target: "For Whom",
        howItWorks: "Guide",
        faq: "FAQ",
        wallpaper: "Wallpaper"
    },
    hero: {
        headline: "Unlock the Full Power of Your PC.<br>Now Free & Open Source.",
        subheadline: "A free and open-source kernel and system optimization project designed to reduce bottlenecks, maximize hardware and software performance, and provide users with complete control over their systems."
    },
    welcome: {
        title: "The Platinum+ Optimizer program is finally here!!",
        subtitle: "Now available, free and open source for everyone",
        btnDiscord: "Join our Discord server"
    },
    about: {
        title: "What is Platinum+ Optimizer",
        description1: "Platinum+ Optimizer is a free, open-source PowerShell tool that gives Windows users complete control over their PC's performance. Through a user-friendly GUI and detailed guides, it allows you to manually remove unnecessary software and configure advanced optimizations for gaming, low latency, and overall efficiency.",
        description2: "Unlike automated optimizers, it ensures full transparency by requiring manual application for every well-documented tweak. Furthermore, a built-in recovery system lets you safely experiment and instantly revert any changes, guaranteeing total peace of mind."
    },
    target: {
        title: "Who is it for",
        subtitle: "Created for anyone wanting to take back control of their PC, combining maximum performance with long-term efficiency.",
        items: [
            {
                title: "For Everyone",
                description: "Accessible to anyone, from beginners to power users, with clear, step-by-step guides to safely and consciously optimize your system.",
                icon: "users"
            },
            {
                title: "Gamers & Power Users",
                description: "Maximization of hardware performance, elimination of bottlenecks and input lag, for a smooth, uncompromising gaming and desktop experience.",
                icon: "gamepad-2"
            },
            {
                title: "Privacy & Control Enthusiasts",
                description: "Full control over your operating system: removal of telemetry, bloatware, and unnecessary background processes, ensuring absolute transparency.",
                icon: "shield-check"
            },
            {
                title: "Long-Term Efficiency Seekers",
                description: "Reduction of resource waste, extending hardware lifespan without resorting to harmful 'miracle tweaks' that compromise PC stability.",
                icon: "activity"
            }
        ]
    },
    faq: {
        title: "Common Questions",
        subtitle: "Answers to the most common questions about optimization",
        items: [
            {
                question: "Are the changes reversible?",
                answer: "Yes. The program asks if you want to create a system restore point before applying any changes."
            },
            {
                question: "Do I need to disable the antivirus?",
                answer: "Usually no, but if Windows Defender blocks it, you may need to add an exception."
            },
            {
                question: "Does it improve FPS in games?",
                answer: "Absolutely! By eliminating bottlenecks and optimizing component priorities."
            },
            {
                question: "Do you need assistance?",
                answer: "In case of technical problems or doubts, you can contact our official support at the email address: platinumoptimizerhelp@gmail.com"
            }
        ]
    },
    footer: {
        copyright: "© 2026 Platinum+ Optimizer. All rights reserved.",
        disclaimer: "Use of this tool is at the user's sole risk. We are not responsible for any direct or indirect damage.",
        privacy: "Privacy Policy",
        legalDisclaimer: "Legal Disclaimer",
        closeBtn: "Close",
        credits: {
            owner: "Owner & Tweak Dev",
            webdeveloper: "Web Developer"
        },
        creators: "Creators",
        support: "Support & Community",
        telegramBtn: "Join the group",
        donationsBtn: "Donations",
        emailSupportBtn: "Email Support"
    },
    wallpaperPage: {
        title: "Platinum+ <span class=\"text-electric\">Wallpapers</span>",
        subtitle: "The ultimate 4K aesthetic for high-performance setups. Designed to elevate your visual experience.",
        preview: "Preview",
        download4k: "DOWNLOAD 4K MASTERPIECE",
        wallpapers: {
            w1: { name: "Platinum v8", desc: "4K Ultra • Deep Architecture" },
            w2: { name: "Aqua Flow", desc: "4K Ultra • Android Core" },
            w3: { name: "Dark Horizon", desc: "4K Ultra • Stealth Optimizer" },
            w4: { name: "Electric Pulse", desc: "4K Ultra • Frequency Boost" },
            w5: { name: "Abstract Core", desc: "4K Ultra • Kernel Logic" },
            w6: { name: "Crystal Clear", desc: "4K Ultra • Maximum Transparency" }
        }
    }
};

const LEGAL_CONTENT = {
    privacy: [
        "1. Data Collection: Platinum+ Optimizer does not collect, store, or transmit any personal user data.",
        "2. Local Execution: All code runs locally on the user's machine without communication to external servers.",
        "3. No Telemetry: The software includes no telemetry, tracking, or behavioral analysis modules.",
        "4. Source Code: As an optimization tool, operations are verifiable via system behavior.",
        "5. Internet Connection: The program does not require an active internet connection to function, ensuring data isolation.",
        "6. System Logs: Any generated logs are saved exclusively locally and are temporary.",
        "7. Windows Registry: Registry changes do not access keys containing sensitive user data.",
        "8. Credentials: Login credentials, passwords, or tokens are never requested or accessed.",
        "9. Cookies: The website and executable do not use profiling cookies.",
        "10. Third Parties: No data is shared with third parties, advertising partners, or affiliates.",
        "11. GDPR Compliance: Although operating locally, the 'Privacy by Design' principle is fully respected.",
        "12. User Files: The program does not scan, modify, or delete personal files (documents, photos, etc.).",
        "13. Peripherals: Peripheral lists or unique hardware identifiers are not collected for tracking purposes.",
        "14. IP Address: No logging of the user's IP address is performed.",
        "15. Geolocation: No geolocation functionality is present in the software.",
        "16. Updates: The search for updates is manual; there are no automatic background connections.",
        "17. Advertising: The software is free of adware or advertising insertions.",
        "18. Minors: Since no data is collected, there is no risk to the privacy of minors.",
        "19. Security: The absence of network communications eliminates remote attack vectors via the software.",
        "20. Profiling: No profiling of hardware or user habits is created."
    ],
    disclaimer: `LIMITATION OF LIABILITY (DISCLAIMER)

1. ACCEPTANCE OF RISKS
The use of the software "Platinum+ Optimizer" (hereinafter "Software") is at the user's sole discretion and risk. The Software is provided "AS IS", without any express or implied warranty of operation, stability, or fitness for a particular purpose.

2. SYSTEM MODIFICATIONS
The Software makes deep changes to the Microsoft Windows operating system, including but not limited to: System Registry, Services, CPU Scheduler, Memory Management, and Network Configurations. Although designed to improve performance, such changes could cause instability, software incompatibility, or unexpected behavior in specific hardware configurations.

3. EXCLUSION OF DAMAGES
In no event shall the developers (a team of two independent people), distributors, or collaborators of Platinum+ Optimizer be liable for direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to: loss of data, OS corruption, hardware failure, business interruption, or loss of profits) arising from the use or inability to use the Software.

4. RESTORE POINTS
It is the user's sole responsibility to ensure that a System Restore Point or a full backup of critical data is created before running the Software. The developers do not guarantee the effectiveness of the native Windows restore function.

5. OVERCLOCK AND HARDWARE
Optimizations that remove power limits may increase the operating temperature and power consumption of components (CPU/GPU). The user is responsible for monitoring temperatures and thermal stability of their system.

6. VIOLATION OF THIRD-PARTY TERMS
The use of optimization scripts could, in rare cases, be interpreted as a violation of the Terms of Service of some anti-cheat software or corporate applications. The user assumes full responsibility for compliance with third-party agreements.

7. NON-AFFILIATION
Platinum+ Optimizer is not affiliated, associated, authorized, endorsed by, or in any way officially connected with Microsoft Corporation or any of its subsidiaries.

By executing the program, the user declares to have read, understood, and fully accepted the terms of this disclaimer.`
};

// ============ UTILITY FUNCTIONS ============
function getAppContent() {
    return APP_CONTENT;
}

function getLegalContent() {
    return LEGAL_CONTENT;
}

function getNestedValue(obj, path) {
    return path.split('.').reduce((prev, curr) => prev ? prev[curr] : null, obj);
}

// ============ GLOBAL VARIABLES ============
let isScrolled = false;
let mobileMenuOpen = false;

// ============ INITIALIZATION ============
document.addEventListener('DOMContentLoaded', () => {
    // Aggressive visibility restoration (Anti-FOUC)
    document.documentElement.style.visibility = 'visible';
    document.documentElement.style.opacity = '1';

    // Initial render
    updateLanguage();
    initCustomLanguageSelector();
    if (window.lucide) {
        lucide.createIcons();
    }


    // Scroll listener
    window.addEventListener('scroll', () => {
        const scrolled = window.scrollY > 50;
        if (scrolled !== isScrolled) {
            isScrolled = scrolled;
            const nav = document.getElementById('navbar');
            if (nav) {
                if (scrolled) {
                    nav.classList.add('py-4');
                    nav.classList.remove('py-6');
                } else {
                    nav.classList.remove('py-4');
                    nav.classList.add('py-6');
                }
            }
        }
    });

    // Grid animation
    initGridAnimation('deep-space', false);

    // Systems initialization
    initClickExplosion();
    initScrollAnimations();
    initLiquidScroll();
    initHero3DMockup();
    initNavBlob();
    initFPSCounter();

    // Welcome Popup
    initWelcomePopup();
});

function updateLanguage() {
    const content = getAppContent();
    const legalContent = getLegalContent();

    // Simple text updates
    document.querySelectorAll('[data-i18n]').forEach(el => {
        const key = el.getAttribute('data-i18n');
        const value = getNestedValue(content, key);
        if (value) el.innerHTML = value;
    });

    // Target Audience
    const targetContainer = document.getElementById('target-items-container');
    if (targetContainer && content.target) {
        targetContainer.innerHTML = content.target.items.map(item => `
            <div class="group relative bg-platinum-900/40 p-8 border border-white/5 hover:border-electric-500/50 transition-all duration-500 hover:-translate-y-2 rounded-2xl shadow-2xl backdrop-blur-sm overflow-hidden">
                <div class="absolute -right-8 -top-8 w-32 h-32 bg-electric-500/5 rounded-full group-hover:bg-electric-500/10 transition-colors duration-500"></div>
                <div class="relative z-10">
                    <div class="w-14 h-14 bg-gradient-to-br from-electric-500/20 to-electric-600/5 rounded-xl flex items-center justify-center mb-8 text-electric-400 group-hover:scale-110 transition-transform duration-500 border border-electric-500/20 group-hover:shadow-glow">
                        <i data-lucide="${item.icon}" class="w-7 h-7" stroke-width="1.5"></i>
                    </div>
                    <h3 class="text-2xl font-serif font-bold mb-4 text-white tracking-tight">${item.title}</h3>
                    <p class="text-platinum-300 font-light leading-relaxed text-base">${item.description}</p>
                </div>
                <div class="absolute bottom-0 left-0 h-1 w-0 bg-electric-500 transition-all duration-500 group-hover:w-full"></div>
            </div>
        `).join('');
    }

    // FAQ
    const faqList = document.getElementById('faq-list');
    if (faqList && content.faq) {
        faqList.innerHTML = content.faq.items.map((item, index) => `
            <div class="group border border-white/5 bg-platinum-950/40 backdrop-blur-md rounded-2xl transition-all duration-500 hover:border-electric-500/30 hover:bg-platinum-900/60 overflow-hidden shadow-lg">
                <button onclick="toggleAccordion(event, ${index})" 
                        class="w-full px-8 py-6 flex items-center justify-between text-left focus:outline-none group">
                    <span id="faq-q-${index}" 
                          class="text-lg md:text-xl font-medium tracking-tight text-platinum-100 group-hover:text-white transition-colors duration-300">${item.question}</span>
                    <div class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center group-hover:bg-electric-500/20 transition-all duration-300">
                        <i id="faq-icon-${index}" data-lucide="chevron-down" 
                           class="w-5 h-5 text-platinum-400 group-hover:text-electric-400 transition-transform duration-500 ease-[cubic-bezier(0.34,1.56,0.64,1)]"></i>
                    </div>
                </button>
                <div id="faq-ans-${index}" 
                     class="grid grid-rows-[0fr] transition-all duration-700 ease-[cubic-bezier(0.34,1.56,0.64,1)] opacity-0 overflow-hidden">
                    <div class="min-h-0">
                        <div class="px-8 pb-8 pt-2 text-platinum-300/90 leading-relaxed font-light text-base md:text-lg border-t border-white/5 mx-8">
                            ${item.answer}
                        </div>
                    </div>
                </div>
            </div>
        `).join('');
    }

    // Modals Content
    const privacyContent = document.getElementById('modal-content-privacy');
    if (privacyContent && Array.isArray(legalContent.privacy)) {
        privacyContent.innerHTML = `<ul class="space-y-4">${legalContent.privacy.map(p => `
            <li class="flex gap-4"><span class="text-platinum-50 font-medium">${p}</span></li>
        `).join('')}</ul>`;
    }

    const disclaimerContent = document.getElementById('modal-content-disclaimer');
    if (disclaimerContent) disclaimerContent.textContent = legalContent.disclaimer;

    if (window.lucide) {
        lucide.createIcons();
    }
}

// ============ INTERACTION FUNCTIONS ============
window.scrollToSection = (id) => {
    if (mobileMenuOpen) toggleMobileMenu();
    const element = document.getElementById(id);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
    }
};

window.toggleMobileMenu = () => {
    mobileMenuOpen = !mobileMenuOpen;
    const menu = document.getElementById('mobile-menu');
    const icon = document.getElementById('mobile-menu-icon');

    if (mobileMenuOpen) {
        menu.classList.remove('hidden');
        menu.classList.add('flex');
        icon.setAttribute('data-lucide', 'x');
    } else {
        menu.classList.add('hidden');
        menu.classList.remove('flex');
        icon.setAttribute('data-lucide', 'menu');
    }
    if (window.lucide) lucide.createIcons();
};

// ============ UNIFIED MODAL SYSTEM (iOS 27 FLIP Animation) ============
window.openModal = (type, trigger) => {
    const modal = document.getElementById(`modal-${type}`);
    if (!modal) return;

    const legacyModals = ['welcome', 'socials', 'privacy', 'disclaimer'];
    if (legacyModals.includes(type)) {
        const modalContent = modal.querySelector('.liquid-glass-modal');

        let triggerBtn = trigger;
        if (!triggerBtn && window.event && window.event.currentTarget) {
            triggerBtn = window.event.currentTarget.tagName === 'BUTTON' ? window.event.currentTarget : window.event.target.closest('button') || window.event.target.closest('a');
        }

        if (triggerBtn) {
            modal.dataset.triggerId = triggerBtn.id || `trigger-${Math.random().toString(36).substr(2, 9)}`;
            if (!triggerBtn.id) triggerBtn.id = modal.dataset.triggerId;

            const rect = triggerBtn.getBoundingClientRect();
            const startX = rect.left + rect.width / 2 - window.innerWidth / 2;
            const startY = rect.top + rect.height / 2 - window.innerHeight / 2;
            const startScale = rect.width / (window.innerWidth * 0.9);

            modalContent.style.setProperty('--start-x', `${startX}px`);
            modalContent.style.setProperty('--start-y', `${startY}px`);
            modalContent.style.setProperty('--start-scale', `${startScale.toFixed(4)}`);

            triggerBtn.style.transition = 'opacity 0.18s ease';
            triggerBtn.style.opacity = '0';
            triggerBtn.style.pointerEvents = 'none';
        } else {
            modalContent.style.setProperty('--start-x', '0px');
            modalContent.style.setProperty('--start-y', '100px');
            modalContent.style.setProperty('--start-scale', '0.8');
        }

        modalContent.style.animation = 'none';
        modalContent.offsetHeight;
        modalContent.style.animation = 'liquid-drop-entry 0.55s cubic-bezier(0.23, 1, 0.32, 1) forwards';

        modal.classList.remove('hidden');
        requestAnimationFrame(() => modal.classList.add('modal-active'));
        document.body.style.overflow = 'hidden';

        if (window.bgAnimation) window.bgAnimation.modalActive = true;

        const ripple = document.createElement('div');
        ripple.className = 'liquid-ripple';
        modalContent.appendChild(ripple);
        setTimeout(() => ripple.remove(), 1000);
        return;
    }

    const modalContent = modal.querySelector('.liquid-glass-modal');
    const backdrop = modal.querySelector('.modal-backdrop') || modal.querySelector('[onclick*="closeModal"]');

    let triggerBtn = trigger;
    if (!triggerBtn && window.event && window.event.currentTarget) {
        triggerBtn = window.event.currentTarget.tagName === 'BUTTON' ? window.event.currentTarget : window.event.target.closest('button') || window.event.target.closest('a');
    }

    if (triggerBtn) {
        modal.dataset.triggerId = triggerBtn.id || `trigger-${Math.random().toString(36).substr(2, 9)}`;
        if (!triggerBtn.id) triggerBtn.id = modal.dataset.triggerId;

        const triggerTransform = triggerBtn.style.transform || '';
        const prevTransition = triggerBtn.style.transition;
        triggerBtn.style.transition = 'none';
        triggerBtn.style.transform = 'none';
        const firstRect = triggerBtn.getBoundingClientRect();
        triggerBtn.style.transform = triggerTransform;
        triggerBtn.style.transition = prevTransition;

        triggerBtn.style.transition = 'opacity 0.15s ease';
        triggerBtn.style.opacity = '0';
        triggerBtn.style.pointerEvents = 'none';

        modal.classList.remove('hidden');
        modal.style.opacity = '1';
        modal.style.transition = 'none';

        modalContent.style.animation = 'none';
        modalContent.style.transition = 'none';
        modalContent.style.transform = 'none';
        modalContent.style.opacity = '1';
        modalContent.style.borderRadius = '';

        if (backdrop && backdrop.classList.contains('modal-backdrop')) {
            backdrop.style.transition = 'none';
            backdrop.style.background = 'rgba(0,0,0,0)';
            backdrop.style.backdropFilter = 'blur(0px)';
            backdrop.style.webkitBackdropFilter = 'blur(0px)';
        }

        requestAnimationFrame(() => {
            const lastRect = modalContent.getBoundingClientRect();

            const scaleX = firstRect.width / lastRect.width;
            const scaleY = firstRect.height / lastRect.height;
            const deltaX = firstRect.left + (firstRect.width / 2) - (lastRect.left + (lastRect.width / 2));
            const deltaY = firstRect.top + (firstRect.height / 2) - (lastRect.top + (lastRect.height / 2));

            modalContent.style.transform = `translate(${deltaX}px, ${deltaY}px) scale(${scaleX}, ${scaleY}) ${triggerTransform}`;
            modalContent.style.borderRadius = '3rem';
            modalContent.style.opacity = '1';
            modalContent.offsetHeight;

            modal.classList.add('modal-active');

            if (backdrop && backdrop.classList.contains('modal-backdrop')) {
                backdrop.style.transition = 'background 0.55s cubic-bezier(0.23, 1, 0.32, 1), backdrop-filter 0.55s cubic-bezier(0.23, 1, 0.32, 1), -webkit-backdrop-filter 0.55s cubic-bezier(0.23, 1, 0.32, 1)';
                backdrop.style.background = 'rgba(0,0,0,0.75)';
                backdrop.style.backdropFilter = 'blur(20px) saturate(180%)';
                backdrop.style.webkitBackdropFilter = 'blur(20px) saturate(180%)';
            }

            modalContent.style.transition = 'transform 0.55s cubic-bezier(0.23, 1, 0.32, 1), border-radius 0.55s cubic-bezier(0.23, 1, 0.32, 1)';
            modalContent.style.transform = 'translate(0, 0) scale(1)';
            modalContent.style.borderRadius = '';
        });
    } else {
        modal.classList.remove('hidden');
        modal.style.opacity = '1';
        modal.style.transition = 'none';

        modalContent.style.animation = 'none';
        modalContent.style.transition = 'none';
        modalContent.style.transform = 'translateY(40px) scale(0.85)';
        modalContent.style.opacity = '0';
        modalContent.offsetHeight;

        requestAnimationFrame(() => {
            modal.classList.add('modal-active');
            modalContent.style.transition = 'transform 0.7s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.4s ease-out';
            modalContent.style.transform = 'translate(0, 0) scale(1)';
            modalContent.style.opacity = '1';
        });
    }

    document.body.style.overflow = 'hidden';
    if (window.bgAnimation) window.bgAnimation.modalActive = true;
};

window.closeModal = (type) => {
    const modal = document.getElementById(`modal-${type}`);
    if (!modal) return;

    const legacyModals = ['welcome', 'socials', 'privacy', 'disclaimer'];
    if (legacyModals.includes(type)) {
        const modalContent = modal.querySelector('.liquid-glass-modal');
        const triggerBtn = document.getElementById(modal.dataset.triggerId);

        modal.classList.remove('modal-active');
        modalContent.style.animation = 'liquid-drop-exit 0.45s cubic-bezier(0.4, 0, 1, 1) forwards';

        setTimeout(() => {
            modal.classList.add('hidden');
            const remainingModals = document.querySelectorAll('.fixed:not(.hidden).modal-active');
            if (remainingModals.length === 0) {
                document.body.style.overflow = '';
                if (window.bgAnimation) window.bgAnimation.modalActive = false;
            }
            if (triggerBtn) {
                triggerBtn.style.transition = 'opacity 0.25s ease';
                triggerBtn.style.opacity = '1';
                triggerBtn.style.pointerEvents = '';
            }
        }, 400);
        return;
    }

    const modalContent = modal.querySelector('.liquid-glass-modal');
    const backdrop = modal.querySelector('.modal-backdrop') || modal.querySelector('[onclick*="closeModal"]');
    const triggerBtn = document.getElementById(modal.dataset.triggerId);

    if (type === 'video-intro' || type === 'video') {
        const iframe = document.getElementById('intro-video-frame') || modal.querySelector('iframe');
        if (iframe) iframe.src = '';
    }

    modal.classList.remove('modal-active');

    if (backdrop && backdrop.classList.contains('modal-backdrop')) {
        backdrop.style.transition = 'background 0.4s ease, backdrop-filter 0.4s ease, -webkit-backdrop-filter 0.4s ease';
        backdrop.style.background = 'rgba(0,0,0,0)';
        backdrop.style.backdropFilter = 'blur(0px)';
        backdrop.style.webkitBackdropFilter = 'blur(0px)';
    }

    if (triggerBtn) {
        const triggerTransform = triggerBtn.style.transform || '';
        const prevTransition = triggerBtn.style.transition;
        triggerBtn.style.transition = 'none';
        triggerBtn.style.transform = 'none';

        const currentRect = modalContent.getBoundingClientRect();
        const targetRect = triggerBtn.getBoundingClientRect();

        triggerBtn.style.transform = triggerTransform;
        triggerBtn.style.transition = prevTransition;

        const scaleX = targetRect.width / currentRect.width;
        const scaleY = targetRect.height / currentRect.height;
        const deltaX = targetRect.left + (targetRect.width / 2) - (currentRect.left + (currentRect.width / 2));
        const deltaY = targetRect.top + (targetRect.height / 2) - (currentRect.top + (currentRect.height / 2));

        const sX = isFinite(scaleX) && !isNaN(scaleX) ? scaleX : 1;
        const sY = isFinite(scaleY) && !isNaN(scaleY) ? scaleY : 1;
        const dX = isFinite(deltaX) && !isNaN(deltaX) ? deltaX : 0;
        const dY = isFinite(deltaY) && !isNaN(deltaY) ? deltaY : 0;

        modalContent.animate([
            { transform: 'translate(0px, 0px) scale(1)', borderRadius: '3rem' },
            { transform: `translate(${dX}px, ${dY}px) scale(${sX}, ${sY}) ${triggerTransform}`, borderRadius: '3rem' }
        ], {
            duration: 450,
            easing: 'cubic-bezier(0.32, 0.72, 0, 1)',
            fill: 'forwards'
        });
    } else {
        modalContent.style.transition = 'transform 0.45s cubic-bezier(0.32, 0.72, 0, 1), opacity 0.35s ease-in';
        modalContent.style.transform = 'translateY(30px) scale(0.85)';
        modalContent.style.opacity = '0';
    }

    setTimeout(() => {
        modal.classList.add('hidden');
        if (modalContent.getAnimations) {
            modalContent.getAnimations().forEach(anim => anim.cancel());
        }
        modalContent.style.transform = 'none';
        modalContent.style.transition = '';
        modalContent.style.opacity = '';
        modal.style.opacity = '';

        if (backdrop && backdrop.classList.contains('modal-backdrop')) {
            backdrop.style.transition = '';
            backdrop.style.background = '';
            backdrop.style.backdropFilter = '';
            backdrop.style.webkitBackdropFilter = '';
        }

        const remainingModals = document.querySelectorAll('.fixed:not(.hidden).modal-active');
        if (remainingModals.length === 0) {
            document.body.style.overflow = '';
            if (window.bgAnimation) window.bgAnimation.modalActive = false;
        }

        if (triggerBtn) {
            triggerBtn.style.transition = 'opacity 0.25s ease';
            triggerBtn.style.opacity = '1';
            triggerBtn.style.pointerEvents = '';
        }
    }, 450);
};

window.toggleAccordion = (event, index) => {
    const ans = document.getElementById(`faq-ans-${index}`);
    const icon = document.getElementById(`faq-icon-${index}`);
    const question = document.getElementById(`faq-q-${index}`);

    const isOpen = ans.classList.contains('grid-rows-[1fr]');

    if (!isOpen) {
        document.querySelectorAll('[id^="faq-ans-"]').forEach((el) => {
            if (el.classList.contains('grid-rows-[1fr]')) {
                const otherIndex = el.id.replace('faq-ans-', '');
                el.classList.replace('grid-rows-[1fr]', 'grid-rows-[0fr]');
                el.classList.replace('opacity-100', 'opacity-0');
                document.getElementById(`faq-icon-${otherIndex}`)?.classList.remove('rotate-180', 'text-electric-400');
                document.getElementById(`faq-q-${otherIndex}`)?.classList.remove('text-electric-400');
            }
        });

        ans.classList.replace('grid-rows-[0fr]', 'grid-rows-[1fr]');
        ans.classList.replace('opacity-0', 'opacity-100');

        const rect = event.currentTarget.getBoundingClientRect();
        const ripple = document.createElement('div');
        ripple.className = 'liquid-ripple';
        ripple.style.left = `${event.clientX - rect.left}px`;
        ripple.style.top = `${event.clientY - rect.top}px`;
        ripple.style.setProperty('--glow-color', 'rgba(0, 242, 255, 0.4)');
        event.currentTarget.closest('.group').appendChild(ripple);
        setTimeout(() => ripple.remove(), 800);

        icon.classList.add('rotate-180', 'text-electric-400');
        question.classList.add('text-electric-400');
    } else {
        ans.classList.replace('grid-rows-[1fr]', 'grid-rows-[0fr]');
        ans.classList.replace('opacity-100', 'opacity-0');
        icon.classList.remove('rotate-180', 'text-electric-400');
        question.classList.remove('text-electric-400');
    }
};

// ============ ANIMATIONS ============
function initGridAnimation(theme = 'platinum', showShapes = true) {
    const container = document.getElementById('global-animation-container');
    if (!container) return;

    class ThreeAnimation {
        constructor(container, theme, showShapes = true) {
            this.container = container;
            this.theme = theme;
            this.showShapes = showShapes;
            this.scene = new THREE.Scene();
            this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 3000);
            this.renderer = new THREE.WebGLRenderer({
                antialias: true,
                alpha: true,
                powerPreference: "high-performance",
                precision: "highp",
                stencil: false,
                depth: true
            });

            this.renderer.setSize(window.innerWidth, window.innerHeight);
            this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
            this.container.appendChild(this.renderer.domElement);

            this.camera.position.z = 1000;
            this.shapes = [];
            this.orbs = [];
            this.connections = null;
            this.time = 0;
            this.mouse = new THREE.Vector2(-9999, -9999);
            this.raycaster = new THREE.Raycaster();
            this.modalActive = false;
            this.modalFactor = 0;
            this.atmosphere = null;
            this.particleData = [];

            this.init();
        }

        init() {
            this.addLights();
            this.createAtmosphere();
            if (this.showShapes) this.createShapes();
            this.createLineSystem();
            this.setupListeners();
            this.animate();
        }

        addLights() {
            const ambientLight = new THREE.AmbientLight(0xffffff, 0.15);
            this.scene.add(ambientLight);

            const lightColor = this.theme === 'red' ? 0xff0000 : 0x00f2ff;
            this.mainPointLight = new THREE.PointLight(lightColor, 2, 1500);
            this.scene.add(this.mainPointLight);

            this.cursorLight = new THREE.PointLight(lightColor, 4, 1000);
            this.scene.add(this.cursorLight);

            const canvas = document.createElement('canvas');
            canvas.width = 64;
            canvas.height = 64;
            const ctx = canvas.getContext('2d');
            const gradient = ctx.createRadialGradient(32, 32, 0, 32, 32, 32);

            if (this.theme === 'red') {
                gradient.addColorStop(0, 'rgba(255, 50, 0, 0.4)');
                gradient.addColorStop(0.5, 'rgba(150, 0, 0, 0.1)');
                gradient.addColorStop(1, 'rgba(0, 0, 0, 0)');
            } else {
                gradient.addColorStop(0, 'rgba(0, 242, 255, 0.4)');
                gradient.addColorStop(0.5, 'rgba(31, 111, 255, 0.1)');
                gradient.addColorStop(1, 'rgba(0, 0, 0, 0)');
            }

            ctx.fillStyle = gradient;
            ctx.fillRect(0, 0, 64, 64);
            const texture = new THREE.CanvasTexture(canvas);
            const material = new THREE.SpriteMaterial({ map: texture, transparent: true, blending: THREE.AdditiveBlending, opacity: 0.5 });
            this.cursorGlow = new THREE.Sprite(material);
            this.cursorGlow.scale.set(100, 100, 1);
            this.scene.add(this.cursorGlow);
        }

        createAtmosphere() {
            const particleCount = 3500;
            const geometry = new THREE.BufferGeometry();
            const positions = new Float32Array(particleCount * 3);
            this.particleData = new Float32Array(particleCount * 3);

            for (let i = 0; i < particleCount; i++) {
                positions[i * 3] = (Math.random() - 0.5) * 3000;
                positions[i * 3 + 1] = (Math.random() - 0.5) * 2000;
                positions[i * 3 + 2] = (Math.random() - 0.5) * 2000;

                this.particleData[i * 3] = (Math.random() - 0.5) * 0.2;
                this.particleData[i * 3 + 1] = (Math.random() - 0.5) * 0.2;
                this.particleData[i * 3 + 2] = (Math.random() - 0.5) * 0.2;
            }

            geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));

            const material = new THREE.PointsMaterial({
                size: 2.2,
                color: this.theme === 'red' ? 0xff4400 : 0x00f2ff,
                transparent: true,
                opacity: 0.5,
                blending: THREE.AdditiveBlending,
                sizeAttenuation: true
            });

            if (this.theme === 'deep-space') {
                material.color.setHex(0x0044ff);
                material.size = 1.8;
                material.opacity = 0.45;
            }

            this.atmosphere = new THREE.Points(geometry, material);
            this.scene.add(this.atmosphere);
        }

        destroyShapes() {
            this.shapes.forEach(s => {
                this.scene.remove(s.mesh);
                if (s.mesh.geometry) s.mesh.geometry.dispose();
                if (s.mesh.material) s.mesh.material.dispose();
            });
            this.shapes = [];
        }

        createShapes() {
            const geometries = [
                new THREE.IcosahedronGeometry(80, 0),
                new THREE.OctahedronGeometry(70, 0),
                new THREE.TorusKnotGeometry(60, 15, 64, 12),
                new THREE.TetrahedronGeometry(90, 0),
                new THREE.DodecahedronGeometry(70, 0)
            ];

            for (let i = 0; i < 12; i++) {
                const geo = geometries[i % geometries.length].clone();
                const mainColor = this.theme === 'red' ? 0xffa500 : 0x00f2ff;
                const emissiveColor = this.theme === 'red' ? 0xff4500 : 0x1F6FFF;

                const material = new THREE.MeshPhysicalMaterial({
                    color: mainColor,
                    wireframe: true,
                    transparent: true,
                    opacity: this.theme === 'red' ? 0.7 : 0.25,
                    emissive: emissiveColor,
                    emissiveIntensity: this.theme === 'red' ? 1.0 : 0.3,
                    clearcoat: 1.0,
                    clearcoatRoughness: 0,
                    reflectivity: 1.0,
                    side: THREE.DoubleSide
                });

                const mesh = new THREE.Mesh(geo, material);
                const originalPositions = geo.attributes.position.array.slice();

                const shape = {
                    mesh: mesh,
                    originalPositions: originalPositions,
                    rotationSpeed: {
                        x: (Math.random() - 0.5) * 0.005,
                        y: (Math.random() - 0.5) * 0.005,
                        z: (Math.random() - 0.5) * 0.005
                    },
                    velocity: new THREE.Vector3(
                        (Math.random() - 0.5) * 0.4,
                        (Math.random() - 0.5) * 0.4,
                        (Math.random() - 0.5) * 0.25
                    ),
                    floatOffset: Math.random() * Math.PI * 2,
                    alterationFactor: 0,
                    entranceFactor: 0,
                    phase: Math.random() * 10
                };

                mesh.position.set(
                    (Math.random() - 0.5) * 2500,
                    (Math.random() - 0.5) * 1800,
                    (Math.random() - 0.5) * 1000
                );

                this.scene.add(mesh);
                this.shapes.push(shape);
            }
        }

        createLineSystem() {
            const geometry = new THREE.BufferGeometry();
            const lineColor = this.theme === 'red' ? 0xff8c00 : 0x00f2ff;
            const material = new THREE.LineBasicMaterial({
                color: lineColor,
                transparent: true,
                opacity: 0.2,
                blending: THREE.AdditiveBlending
            });
            this.connections = new THREE.LineSegments(geometry, material);
            this.scene.add(this.connections);
        }

        setupListeners() {
            window.addEventListener('resize', () => {
                this.camera.aspect = window.innerWidth / window.innerHeight;
                this.camera.updateProjectionMatrix();
                this.renderer.setSize(window.innerWidth, window.innerHeight);
            });

            window.addEventListener('mousemove', (e) => {
                this.mouse.x = (e.clientX / window.innerWidth) * 2 - 1;
                this.mouse.y = -(e.clientY / window.innerHeight) * 2 + 1;
            });
        }

        update() {
            this.modalFactor += ((this.modalActive ? 1 : 0) - this.modalFactor) * 0.05;

            let timeStep = 0.005 * (1 - this.modalFactor * 0.8);
            if (this.theme === 'deep-space') timeStep *= 0.5;
            this.time += timeStep;

            let baseColorValue = 0x00f2ff;
            if (this.theme === 'red') baseColorValue = 0xff0000;
            if (this.theme === 'deep-space') baseColorValue = 0x0044ff;
            const baseColor = new THREE.Color(baseColorValue);

            const modalColor = this.theme === 'red' ? new THREE.Color(0x990000) : new THREE.Color(0x0044ff);
            this.mainPointLight.color.copy(baseColor).lerp(modalColor, this.modalFactor);
            this.mainPointLight.intensity = 5 * (1 - this.modalFactor * 0.3);

            this.raycaster.setFromCamera(this.mouse, this.camera);
            const lightPlane = new THREE.Plane(new THREE.Vector3(0, 0, 1), -200);
            const lightTarget = new THREE.Vector3();
            this.raycaster.ray.intersectPlane(lightPlane, lightTarget);

            this.cursorLight.position.lerp(lightTarget, 0.1);
            this.cursorGlow.position.copy(this.cursorLight.position);

            const pulseIntensity = 18 + Math.sin(this.time * 1.2) * 8;
            this.cursorLight.intensity = pulseIntensity * (1 - this.modalFactor * 0.5);

            const pulseOpacity = 0.7 + Math.sin(this.time * 1.2) * 0.3;
            this.cursorGlow.material.opacity = pulseOpacity * (1 - this.modalFactor * 0.3);

            const pulseScale = 140 + Math.sin(this.time * 1.2) * 40;
            this.cursorGlow.scale.setScalar(pulseScale);

            if (this.atmosphere) {
                const positions = this.atmosphere.geometry.attributes.position.array;
                for (let i = 0; i < positions.length / 3; i++) {
                    positions[i * 3] += this.particleData[i * 3] * (1 + Math.sin(this.time * 0.5 + i) * 0.5);
                    positions[i * 3 + 1] += this.particleData[i * 3 + 1] * (1 + Math.cos(this.time * 0.5 + i) * 0.5);

                    if (Math.abs(positions[i * 3]) > 1500) positions[i * 3] *= -0.99;
                    if (Math.abs(positions[i * 3 + 1]) > 1000) positions[i * 3 + 1] *= -0.99;
                }
                this.atmosphere.geometry.attributes.position.needsUpdate = true;
                this.atmosphere.rotation.y += 0.0005;
                this.atmosphere.rotation.z += 0.0002;
            }

            this.orbs.forEach(o => {
                const velocityScale = 1 - this.modalFactor * 0.85;
                o.pos.x += o.vel.x * velocityScale;
                o.pos.y += o.vel.y * velocityScale;
                o.pos.z += o.vel.z * velocityScale;

                if (Math.abs(o.pos.x) > 1200) o.vel.x *= -1;
                if (Math.abs(o.pos.y) > 900) o.vel.y *= -1;
                if (Math.abs(o.pos.z) > 600) o.vel.z *= -1;

                o.sprite.position.copy(o.pos);
                o.sprite.position.y += Math.sin(this.time + o.phase) * 1.5;
                o.sprite.material.opacity = (0.5 + Math.sin(this.time * 2 + o.phase) * 0.2) * (1 - this.modalFactor * 0.4);
            });

            const linePositions = [];

            this.raycaster.setFromCamera(this.mouse, this.camera);

            this.shapes.forEach((s, i) => {
                const planeZ = new THREE.Plane(new THREE.Vector3(0, 0, 1), -s.mesh.position.z);
                const mouseAtDepth = new THREE.Vector3();
                this.raycaster.ray.intersectPlane(planeZ, mouseAtDepth);

                const distToMouse = s.mesh.position.distanceTo(mouseAtDepth);
                const isNearMouse = distToMouse < 600;
                const proximity = Math.max(0, 1 - distToMouse / 600);

                let speedMultiplier = 1;
                if (isNearMouse) {
                    const baseSlowdown = 1 - proximity * 0.9;
                    const reactiveMove = proximity > 0.7 ? (proximity - 0.7) * 0.5 : 0;
                    speedMultiplier = baseSlowdown + reactiveMove;
                }

                s.mesh.position.x += s.velocity.x * speedMultiplier;
                s.mesh.position.y += s.velocity.y * speedMultiplier;
                s.mesh.position.z += s.velocity.z * speedMultiplier;

                if (s.mesh.position.x > 1500) { s.mesh.position.x = -1500; s.entranceFactor = 0; }
                else if (s.mesh.position.x < -1500) { s.mesh.position.x = 1500; s.entranceFactor = 0; }
                if (s.mesh.position.y > 1000) { s.mesh.position.y = -1000; s.entranceFactor = 0; }
                else if (s.mesh.position.y < -1000) { s.mesh.position.y = 1000; s.entranceFactor = 0; }
                if (s.mesh.position.z > 500) { s.mesh.position.z = -1000; s.entranceFactor = 0; }
                else if (s.mesh.position.z < -1000) { s.mesh.position.z = 500; s.entranceFactor = 0; }

                if (s.entranceFactor < 1) s.entranceFactor += 0.005;

                const margin = 350;
                const distEdgeX = 1500 - Math.abs(s.mesh.position.x);
                const distEdgeY = 1000 - Math.abs(s.mesh.position.y);
                const distEdgeZ = s.mesh.position.z > -250 ? 500 - s.mesh.position.z : s.mesh.position.z - (-1000);
                const exitFactor = Math.min(1, Math.max(0, distEdgeX / margin), Math.max(0, distEdgeY / margin), Math.max(0, distEdgeZ / margin));

                const rotationBoost = isNearMouse ? (1 + proximity * 2.5) : 1;
                s.mesh.rotation.x += s.rotationSpeed.x * rotationBoost;
                s.mesh.rotation.y += s.rotationSpeed.y * rotationBoost;

                const targetAlteration = isNearMouse ? Math.pow(proximity, 1.5) * 3 : 0;
                s.alterationFactor += (targetAlteration - s.alterationFactor) * 0.04;

                const autoCycle = Math.max(0, Math.sin(this.time * 0.4 + s.phase));
                const totalFactor = Math.min(2.0, s.alterationFactor + autoCycle * 0.3);

                const positions = s.mesh.geometry.attributes.position.array;
                const meshMatrixInv = s.mesh.matrixWorld.clone().invert();
                const localMouse = mouseAtDepth.clone().applyMatrix4(meshMatrixInv);

                for (let j = 0; j < positions.length; j += 3) {
                    const ox = s.originalPositions[j];
                    const oy = s.originalPositions[j + 1];
                    const oz = s.originalPositions[j + 2];

                    const norm = Math.sqrt(ox * ox + oy * oy + oz * oz);

                    let vx = (ox / norm) * 70 * totalFactor;
                    let vy = (oy / norm) * 70 * totalFactor;
                    let vz = (oz / norm) * 70 * totalFactor;

                    if (s.alterationFactor > 0.1) {
                        const pullX = (localMouse.x - ox) * 0.15 * s.alterationFactor;
                        const pullY = (localMouse.y - oy) * 0.15 * s.alterationFactor;
                        const pullZ = (localMouse.z - oz) * 0.15 * s.alterationFactor;
                        vx += pullX; vy += pullY; vz += pullZ;
                    }

                    positions[j] = ox + vx;
                    positions[j + 1] = oy + vy;
                    positions[j + 2] = oz + vz;
                }
                s.mesh.geometry.attributes.position.needsUpdate = true;

                if (isNearMouse && this.mouse.x !== -9999) {
                    const vertices = [];
                    for (let k = 0; k < positions.length; k += 6) {
                        vertices.push(new THREE.Vector3(positions[k], positions[k + 1], positions[k + 2]).applyMatrix4(s.mesh.matrixWorld));
                    }
                    vertices.sort((a, b) => a.distanceToSquared(mouseAtDepth) - b.distanceToSquared(mouseAtDepth));

                    const connectionCount = Math.min(4, vertices.length);
                    for (let n = 0; n < connectionCount; n++) {
                        const v = vertices[n];
                        linePositions.push(mouseAtDepth.x, mouseAtDepth.y, mouseAtDepth.z, v.x, v.y, v.z);
                    }
                    this.mainPointLight.position.lerp(mouseAtDepth, 0.1);
                }

                let shapeConnections = 0;
                for (let k = i + 1; k < this.shapes.length; k++) {
                    const other = this.shapes[k];
                    const d = s.mesh.position.distanceTo(other.mesh.position);
                    if (d < 500 && shapeConnections < 4) {
                        linePositions.push(s.mesh.position.x, s.mesh.position.y, s.mesh.position.z);
                        linePositions.push(other.mesh.position.x, other.mesh.position.y, other.mesh.position.z);
                        shapeConnections++;
                    }
                }

                const baseOpacity = 0.12 + (1 - Math.min(1, totalFactor)) * 0.25;
                const visibility = s.entranceFactor * exitFactor;
                s.mesh.material.opacity = baseOpacity * visibility;
                s.mesh.scale.setScalar((0.5 + 0.5 * visibility) * (1 + s.alterationFactor * 0.04));
            });

            this.connections.geometry.setAttribute('position', new THREE.Float32BufferAttribute(linePositions, 3));
            this.connections.geometry.attributes.position.needsUpdate = true;
            this.connections.material.opacity = Math.min(0.2, linePositions.length / 40);
        }

        animate() {
            requestAnimationFrame(() => this.animate());
            this.update();
            this.renderer.render(this.scene, this.camera);
        }
    }

    window.bgAnimation = new ThreeAnimation(container, theme, showShapes);
}

// ============ CLICK EFFECT (Cyber Ripple) ============
function createParticleExplosion(x, y) {
    const container = document.createElement('div');
    container.className = 'click-ripple-container';
    container.style.left = `${x}px`;
    container.style.top = `${y}px`;
    document.body.appendChild(container);

    const sparkCount = 8;
    for (let i = 0; i < sparkCount; i++) {
        const spark = document.createElement('div');
        spark.className = 'ripple-spark';

        const angle = (i / sparkCount) * 360 + (Math.random() * 20 - 10);
        const dist = 40 + Math.random() * 30;
        const duration = 0.6 + Math.random() * 0.4;
        const delay = Math.random() * 0.05;

        spark.style.setProperty('--angle', `${angle}deg`);
        spark.style.setProperty('--dist', `${dist}px`);
        spark.style.animation = `spark-flight ${duration}s cubic-bezier(0.15, 0.8, 0.25, 1) ${delay}s forwards`;

        container.appendChild(spark);
    }

    setTimeout(() => {
        container.remove();
    }, 1500);
}

function initClickExplosion() {
    window.addEventListener('mousedown', (e) => {
        createParticleExplosion(e.clientX, e.clientY);
    });
}

// ============ SCROLL ANIMATIONS ============
function initScrollAnimations() {
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.reveal-on-scroll, .scale-up-on-scroll').forEach(el => {
        observer.observe(el);
    });
}

// ============ DYNAMIC 3D MOCKUP TILT & SCROLL ============
function initHero3DMockup() {
    const mockup = document.getElementById('hero-3d-mockup');
    const buttonsParallax = document.getElementById('hero-buttons-parallax');
    if (!mockup) return;

    const baseRotateX = 6;
    const baseRotateY = 10;
    const baseRotateZ = -2;
    const baseScale = 1.15;

    let currentRotateX = baseRotateX;
    let currentRotateY = baseRotateY;
    let currentRotateZ = baseRotateZ;
    let currentScale = baseScale;
    let currentTranslateY = 0;
    let currentTranslateYButtons = 0;

    function update() {
        const scrollY = window.pageYOffset;

        const maxScroll = 600;
        const scrollFactor = Math.min(1, scrollY / maxScroll);

        const targetX = baseRotateX * (1 - scrollFactor);
        const targetY = baseRotateY * (1 - scrollFactor);
        const targetZ = baseRotateZ * (1 - scrollFactor);
        const targetScale = baseScale;

        const targetTranslateY = scrollY * -0.15;
        const targetTranslateYButtons = scrollY * -0.18;

        currentRotateX += (targetX - currentRotateX) * 0.08;
        currentRotateY += (targetY - currentRotateY) * 0.08;
        currentRotateZ += (targetZ - currentRotateZ) * 0.08;
        currentScale += (targetScale - currentScale) * 0.08;
        currentTranslateY += (targetTranslateY - currentTranslateY) * 0.08;
        currentTranslateYButtons += (targetTranslateYButtons - currentTranslateYButtons) * 0.08;

        mockup.style.transform = `
            rotateX(${currentRotateX.toFixed(3)}deg)
            rotateY(${currentRotateY.toFixed(3)}deg)
            rotateZ(${currentRotateZ.toFixed(3)}deg)
            translateY(${currentTranslateY.toFixed(2)}px)
            scale(${currentScale.toFixed(4)})
        `;

        if (buttonsParallax) {
            buttonsParallax.style.transform = `translateY(${currentTranslateYButtons.toFixed(2)}px)`;
        }

        const shadowDistance = (30 + currentTranslateY * -0.05).toFixed(1);
        mockup.style.boxShadow = `0 ${shadowDistance}px 100px rgba(31, 111, 255, 0.25)`;

        requestAnimationFrame(update);
    }

    update();
}

// ============ LIQUID GLASS MORPHING ============
function initLiquidScroll() {
    const targets = Array.from(document.querySelectorAll('.glass, .liquid-glass, section, i, button, nav, [class*="rounded-"]'))
        .filter(el => !el.closest('#hero-3d-mockup') && !el.closest('#navbar') && !el.closest('footer') && !el.closest('#fps-counter-widget') && el.id !== 'fps-counter-widget' && el.tagName.toLowerCase() !== 'img');


    targets.forEach(el => {
        el.style.willChange = 'transform, border-radius';
        el.style.backfaceVisibility = 'hidden';
    });

    let currentScroll = window.pageYOffset;
    let scrollVelocity = 0;
    let lerpVelocity = 0;

    function update() {
        const newScroll = window.pageYOffset;
        scrollVelocity = (newScroll - currentScroll);
        currentScroll = newScroll;

        lerpVelocity += (scrollVelocity - lerpVelocity) * 0.35;
        const absVel = Math.abs(lerpVelocity);

        const stretchY = 1 + Math.min(0.03, absVel * 0.00015);
        const compressX = 1 / stretchY;
        const radiusWarp = Math.min(3, absVel * 0.02);
        const skew = Math.max(-0.5, Math.min(0.5, lerpVelocity * 0.003));

        targets.forEach(el => {
            const rect = el.getBoundingClientRect();
            if (rect.top < window.innerHeight && rect.bottom > 0) {
                el.style.transform = `
                    skewY(${skew.toFixed(2)}deg) 
                    scaleX(${compressX.toFixed(3)}) 
                    scaleY(${stretchY.toFixed(3)})
                    translateY(${(lerpVelocity * -0.08).toFixed(2)}px)
                `;

                if (!el.classList.contains('rounded-full')) {
                    el.style.borderRadius = `${30 + radiusWarp}px ${30 + radiusWarp}px ${30 - radiusWarp}px ${30 - radiusWarp}px / ${30 - radiusWarp}px ${30 - radiusWarp}px ${30 + radiusWarp}px ${30 + radiusWarp}px`;
                }

                if (el.tagName === 'I' || el.tagName === 'BUTTON') {
                    el.style.filter = `blur(${Math.min(1, absVel * 0.01)}px) brightness(${1 + absVel * 0.0005})`;
                }
            }
        });

        requestAnimationFrame(update);
    }

    update();
}

// ============ FPS COUNTER ============
function initFPSCounter() {
    const fpsEl = document.getElementById('fps-count');
    if (!fpsEl) return;

    let lastTime = performance.now();
    let frames = 0;
    let lastFps = 60;
    
    function calculateFPS() {
        const now = performance.now();
        frames++;
        if (now >= lastTime + 250) {
            lastFps = Math.round((frames * 1000) / (now - lastTime));
            fpsEl.textContent = lastFps;
            frames = 0;
            lastTime = now;
        }
        requestAnimationFrame(calculateFPS);
    }
    requestAnimationFrame(calculateFPS);
}

// Zoom Triggers Initialization
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.image-zoom-trigger').forEach(function (trigger) {
        trigger.addEventListener('click', function () {
            var img = trigger.querySelector('img');
            if (img) openLightbox(img.src, trigger);
        });
    });
});

// ============ ULTRA-PROFESSIONAL PAGE NAVIGATION TRANSITION ============
window.navigateTo = function (url) {
    if (!url) return;
    const overlay = document.getElementById('page-transition');
    if (overlay) {
        overlay.classList.add('active');
        setTimeout(() => {
            window.location.href = url;
        }, 380);
    } else {
        window.location.href = url;
    }
};

document.addEventListener('DOMContentLoaded', () => {
    const pageTransition = document.getElementById('page-transition');
    if (pageTransition) {
        setTimeout(() => {
            pageTransition.classList.remove('active');
        }, 120);
    }

    const wallpaperBtn = document.getElementById('nav-wallpaper-btn');
    if (wallpaperBtn) {
        wallpaperBtn.addEventListener('click', (e) => {
            e.preventDefault();
            window.navigateTo(wallpaperBtn.href || 'wallpaper.html');
        });
    }
});

// ============ WELCOME POPUP ============
function initWelcomePopup() {
    const hasSeen = sessionStorage.getItem('has_seen_welcome_v8.3');
    if (hasSeen) return;

    setTimeout(() => {
        window.openModal('welcome');
        sessionStorage.setItem('has_seen_welcome_v8.3', 'true');
    }, 600);
}

// ============ NAVBAR LIQUID BLOB ============
function initNavBlob() {
    const container = document.getElementById('nav-menu-container');
    const blob = document.getElementById('nav-blob');
    if (!container || !blob) return;

    const menuItems = container.querySelectorAll('button, a#nav-wallpaper-btn');
    let lastX = 0;
    let squishTimer = null;

    menuItems.forEach(btn => {
        btn.addEventListener('mouseenter', () => {
            const rect = btn.getBoundingClientRect();
            const containerRect = container.getBoundingClientRect();
            const left = rect.left - containerRect.left;
            const top = rect.top - containerRect.top;

            if (squishTimer) {
                clearTimeout(squishTimer);
                squishTimer = null;
            }

            blob.style.left = `${left}px`;
            blob.style.top = `${top}px`;
            blob.style.width = `${rect.width}px`;
            blob.style.height = `${rect.height}px`;
            blob.style.opacity = '1';
            blob.style.transform = 'scale(1)';

            const currentX = left;
            if (lastX !== 0) {
                const delta = currentX - lastX;
                if (Math.abs(delta) > 5) {
                    if (delta > 0) { blob.style.borderRadius = '60% 40% 60% 40% / 40% 60% 40% 60%'; }
                    else { blob.style.borderRadius = '40% 60% 40% 60% / 60% 40% 60% 40%'; }
                    blob.style.transform = `scaleX(${1 + Math.abs(delta) * 0.002}) scaleY(${1 - Math.abs(delta) * 0.001})`;
                    squishTimer = setTimeout(() => {
                        blob.style.borderRadius = '999px';
                        blob.style.transform = 'scale(1)';
                        squishTimer = null;
                    }, 250);
                } else {
                    blob.style.borderRadius = '999px';
                }
            } else {
                blob.style.borderRadius = '999px';
            }
            lastX = currentX;
        });
    });

    container.addEventListener('mouseleave', () => {
        if (squishTimer) {
            clearTimeout(squishTimer);
            squishTimer = null;
        }
        blob.style.opacity = '0';
        blob.style.transform = 'scale(0.8)';
        blob.style.borderRadius = '999px';
        lastX = 0;
    });
}

// ============ WATER DROP RIPPLE EFFECT ============
document.addEventListener('click', (e) => {
    const trigger = e.target.closest('.ripple-trigger');
    if (trigger) {
        const rippleContainer = document.createElement('div');
        rippleContainer.className = 'click-ripple-container';
        document.body.appendChild(rippleContainer);

        const ripple = document.createElement('div');
        ripple.className = 'ripple-ring';
        ripple.style.left = e.clientX + 'px';
        ripple.style.top = e.clientY + 'px';

        rippleContainer.appendChild(ripple);

        setTimeout(() => {
            rippleContainer.remove();
        }, 1200);
    }
});

// ============ SOCIAL MODAL SYSTEM ============
window.openSocialModal = function (name) {
    const creators = {
        'Stefano': {
            fullName: 'Stefano Morandi',
            role: 'Owner & Tweak Dev',
            photo: 'image/stefano.jpg',
            description: 'Tweak development and testing, technical documentation, troubleshooting, compatibility testing, and reliability improvements.',
            links: [
                { name: 'TikTok', icon: 'image/tiktok.png', url: 'https://www.tiktok.com/@rtx_4060_laptop', color: 'hover:!bg-pink-500/10 hover:!border-pink-500/30' },
                { name: 'Ko-fi', icon: 'image/kofi.png', url: 'https://ko-fi.com/stefano_rtx_4060_laptop', color: 'hover:!bg-orange-500/10 hover:!border-orange-500/30' },
                { name: 'YouTube', icon: 'image/youtube.png', url: 'https://www.youtube.com/@STEFANO_MOR_MUSIC4452', color: 'hover:!bg-red-500/10 hover:!border-red-500/30' },
                { name: 'Telegram', icon: 'image/telegram.png', url: 'https://t.me/STEFANO83223', color: 'hover:!bg-blue-500/10 hover:!border-blue-500/30' },
                { name: 'GitHub', icon: 'image/github.png', url: 'https://github.com/stefanomorandi83762-design', color: 'hover:!bg-gray-500/10 hover:!border-gray-500/30' },
                { name: 'Discord', icon: 'image/discord.png', url: 'https://discord.com/users/1518703063110520983', color: 'hover:!bg-indigo-500/10 hover:!border-indigo-500/30' }
            ]
        },
        'Aledect': {
            fullName: 'Alessio Beltramino',
            role: 'Owner & Manager',
            photo: 'image/aledect.jpg',
            description: 'Program development and software engineering, website development, technical documentation, testing, and troubleshooting.',
            links: [
                { name: 'TikTok', icon: 'image/tiktok.png', url: 'https://www.tiktok.com/@aledect', color: 'hover:!bg-pink-500/10 hover:!border-pink-500/30' },
                { name: 'Ko-fi', icon: 'image/kofi.png', url: 'https://ko-fi.com/platinumoptimizer', color: 'hover:!bg-orange-500/10 hover:!border-orange-500/30' },
                { name: 'YouTube', icon: 'image/youtube.png', url: 'https://youtube.com/@aledect', color: 'hover:!bg-red-500/10 hover:!border-red-500/30' },
                { name: 'Telegram', icon: 'image/telegram.png', url: 'https://t.me/aledect', color: 'hover:!bg-blue-500/10 hover:!border-blue-500/30' },
                { name: 'GitHub', icon: 'image/github.png', url: 'https://github.com/aledect', color: 'hover:!bg-gray-500/10 hover:!border-gray-500/30' },
                { name: 'Discord', icon: 'image/discord.png', url: 'https://discord.com/users/1278098851236151412', color: 'hover:!bg-indigo-500/10 hover:!border-indigo-500/30' }
            ]
        }
    };

    const creator = creators[name];
    if (!creator) return;

    let modal = document.getElementById('modal-socials');
    if (modal) {
        modal.remove();
    }

    const linksHtml = creator.links.map(link => 
        '<a href="' + link.url + '" target="_blank" class="flex items-center gap-3 p-3 rounded-2xl border border-white/5 bg-white/[0.02] ' + link.color + ' text-platinum-300 transition-all duration-300 group/link">' +
            '<div class="w-8 h-8 rounded-xl bg-black/20 group-hover/link:bg-black/40 transition-colors flex items-center justify-center shrink-0">' +
                '<img src="' + link.icon + '" alt="' + link.name + '" class="w-5 h-5 object-contain opacity-80 group-hover/link:opacity-100 transition-opacity">' +
            '</div>' +
            '<span class="text-xs font-semibold tracking-wide flex-1">' + link.name + '</span>' +
            '<i data-lucide="external-link" class="w-3.5 h-3.5 opacity-0 -translate-x-2 group-hover/link:opacity-100 group-hover/link:translate-x-0 transition-all text-white/50 group-hover/link:text-current"></i>' +
        '</a>'
    ).join('');

    const modalHtml = 
    '<div id="modal-socials" class="fixed inset-0 z-[160] flex items-center justify-center p-4 hidden">' +
        '<div class="modal-backdrop" onclick="closeModal(\'socials\')"></div>' +
        '<div class="relative liquid-glass-modal w-full max-w-md flex flex-col items-center justify-center rounded-[3rem] shadow-[0_0_100px_rgba(31,111,255,0.15)] border border-white/10 bg-[#0B1C2D] p-12 gap-8 transform transition-all scale-95 opacity-0" id="social-modal-content">' +
             
             '<button onclick="closeModal(\'socials\')" class="absolute top-6 right-6 p-2 text-platinum-400 hover:text-white hover:bg-white/10 rounded-full transition-all group z-20">' +
                '<i data-lucide="x" class="w-5 h-5 group-hover:rotate-90 transition-transform"></i>' +
             '</button>' +

             '<div class="relative group mt-2">' +
                '<div class="absolute -inset-4 bg-electric-500/20 blur-2xl rounded-full opacity-0 group-hover:opacity-100 transition-opacity"></div>' +
                '<div class="w-28 h-28 rounded-[2rem] bg-platinum-900 border border-white/10 flex items-center justify-center shadow-glow relative z-10 overflow-hidden">' +
                    '<div class="absolute inset-0 bg-gradient-to-tr from-electric-600/20 to-transparent"></div>' +
                    '<img class="absolute inset-0 w-full h-full object-cover" src="' + creator.photo + '" alt="' + creator.fullName + '">' +
                '</div>' +
             '</div>' +

             '<div class="text-center space-y-1 relative z-10">' +
                  '<h3 class="text-3xl font-serif font-bold text-white tracking-tight">' + creator.fullName + '</h3>' +
                  '<p class="text-[10px] text-platinum-400 uppercase tracking-[0.4em] font-bold">' + creator.role + '</p>' +
                  '<p class="text-[11px] text-platinum-300 mt-4 px-2 leading-relaxed opacity-90">' + creator.description + '</p>' +
             '</div>' +

             '<div class="w-full space-y-4 mt-2 relative z-10">' +
                '<div class="flex items-center gap-3 mb-2">' +
                    '<div class="h-px bg-white/5 flex-1"></div>' +
                    '<span class="text-[9px] text-platinum-500 uppercase tracking-[0.3em] font-black">Social Links</span>' +
                    '<div class="h-px bg-white/5 flex-1"></div>' +
                '</div>' +
                '<div class="grid grid-cols-2 gap-3" id="social-links-container">' +
                    linksHtml +
                '</div>' +
             '</div>' +
        '</div>' +
    '</div>';

    document.body.insertAdjacentHTML('beforeend', modalHtml);
    if (typeof lucide !== 'undefined') lucide.createIcons();

    window.openModal('socials');
};

window.closeSocialModal = function() {
    if (window.isSocialModalAnimating) return;
    const modal = document.getElementById('modal-socials');
    const content = document.getElementById('social-modal-content');
    if (!modal || !content) return;

    window.isSocialModalAnimating = true;
    modal.classList.add('opacity-0', 'pointer-events-none');
    content.classList.remove('scale-100', 'opacity-100');
    content.classList.add('scale-95', 'opacity-0');

    setTimeout(() => {
        if (modal && modal.parentNode) modal.remove();
        window.isSocialModalAnimating = false;
    }, 300);
};

// ============ IMAGE LIGHTBOX SYSTEM ============
window.openLightbox = function (src, trigger) {
    const modal = document.getElementById('modal-lightbox');
    const img = document.getElementById('lightbox-img');
    if (!modal || !img) return;

    document.body.style.overflow = 'hidden';
    if (window.bgAnimation) window.bgAnimation.modalActive = true;

    img.src = src;

    const triggerEl = trigger || (window.event && window.event.currentTarget);

    if (triggerEl && typeof FlipEngine !== 'undefined') {
        if (!triggerEl.id) {
            triggerEl.id = 'flip-trigger-' + Math.random().toString(36).substr(2, 9);
        }
        modal.dataset.triggerId = triggerEl.id;

        FlipEngine.animateOpen(triggerEl, img, modal);
    } else {
        modal.dataset.triggerId = '';

        if (typeof FlipEngine !== 'undefined') {
            FlipEngine.animateOpenFallback(img, modal);
        } else {
            modal.style.transition = 'none';
            modal.style.opacity = '1';
            modal.classList.remove('hidden');
            modal.classList.remove('opacity-0');
            modal.classList.add('modal-active');
            requestAnimationFrame(function () {
                img.style.transition = 'transform 0.6s cubic-bezier(0.23, 1, 0.32, 1)';
                img.style.transform = 'translate(0, 0) scale(1)';
            });
        }
    }
};

window.closeLightbox = function () {
    const modal = document.getElementById('modal-lightbox');
    const img = document.getElementById('lightbox-img');
    if (!modal || !img) return;

    const triggerBtnId = modal.dataset.triggerId;
    const triggerBtn = triggerBtnId ? document.getElementById(triggerBtnId) : null;

    if (triggerBtn && typeof FlipEngine !== 'undefined') {
        FlipEngine.animateClose(triggerBtn, img, modal);
    } else if (typeof FlipEngine !== 'undefined') {
        FlipEngine.animateCloseFallback(img, modal);
    } else {
        modal.classList.remove('modal-active');
        img.style.transition = 'transform 0.4s ease-in-out';
        img.style.transform = 'scale(0.8)';

        setTimeout(function () {
            modal.classList.add('hidden');
            img.style.transform = '';
            modal.style.opacity = '';
            document.body.style.overflow = '';
            if (window.bgAnimation) window.bgAnimation.modalActive = false;

            if (triggerBtn) {
                triggerBtn.style.opacity = '1';
                triggerBtn.style.pointerEvents = '';
            }
        }, 400);
    }
};

// ============ TWEAK TOGGLE CARD ANIMATION ============
document.addEventListener('DOMContentLoaded', () => {
    const featuresSection = document.getElementById('features');
    const container = document.getElementById('nvidia-interactive-container');
    const cursor = document.getElementById('animated-mouse-cursor');

    const cards = [];
    const wrappers = [];
    const tracks = [];
    const thumbs = [];
    for (let i = 1; i <= 4; i++) {
        const card = document.getElementById(`tweak-row-card-${i}`);
        const wrapper = document.getElementById(`tweak-toggle-wrapper-${i}`);
        const track = document.getElementById(`tweak-toggle-track-${i}`);
        const thumb = document.getElementById(`tweak-toggle-thumb-${i}`);

        cards.push(card);
        wrappers.push(wrapper);
        tracks.push(track);
        thumbs.push(thumb);
    }

    if (!featuresSection || !container || !cursor || cards.includes(null)) return;

    let clickedStates = [false, false, false, false];
    const targetCardIndex = 1;

    for (let i = 0; i < 4; i++) {
        wrappers[i].addEventListener('click', () => {
            if (i === targetCardIndex) return;

            clickedStates[i] = !clickedStates[i];

            if (clickedStates[i]) {
                tracks[i].classList.add('active');
                thumbs[i].classList.add('active');
            } else {
                tracks[i].classList.remove('active');
                thumbs[i].classList.remove('active');
            }
        });
    }

    let hasAnimatedIn = false;
    let isAnimating = false;

    const easeInOutCubic = t => t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;

    const runTimeBasedAnimation = () => {
        if (isAnimating) return;
        isAnimating = true;
        cursor.style.opacity = '1';

        let startTime = null;
        const durationEnter = 1400;
        const durationClick = 400;
        const durationExit = 1200;

        const animate = (timestamp) => {
            if (!startTime) startTime = timestamp;
            const elapsed = timestamp - startTime;

            const containerRect = container.getBoundingClientRect();
            const trackRect = tracks[targetCardIndex].getBoundingClientRect();

            const targetXOffset = 12;
            const targetYOffset = 12;

            const targetX = trackRect.left - containerRect.left + targetXOffset;
            const targetY = trackRect.top - containerRect.top + targetYOffset;

            const startX = containerRect.width + 150;
            const startY = containerRect.height + 150;

            if (elapsed < durationEnter) {
                const t = easeInOutCubic(elapsed / durationEnter);
                const currentX = startX + (targetX - startX) * t;
                const currentY = startY + (targetY - startY) * t;
                cursor.style.transform = `translate(${currentX}px, ${currentY}px) scale(1) rotate(0deg)`;
                cursor.style.opacity = '1';
                requestAnimationFrame(animate);

            } else if (elapsed < durationEnter + durationClick) {
                const clickProgress = (elapsed - durationEnter) / durationClick;
                let scale = 1;

                if (clickProgress < 0.5) {
                    scale = 1 - (clickProgress * 2 * 0.2);
                } else {
                    scale = 0.8 + ((clickProgress - 0.5) * 2 * 0.2);
                }

                if (clickProgress > 0.5 && !clickedStates[targetCardIndex]) {
                    clickedStates[targetCardIndex] = true;
                    
                    const containerRectNow = container.getBoundingClientRect();
                    const viewportX = targetX + containerRectNow.left;
                    const viewportY = targetY + containerRectNow.top;
                    createParticleExplosion(viewportX, viewportY);
                    
                    tracks[targetCardIndex].classList.add('active');
                    thumbs[targetCardIndex].classList.add('active');
                }

                cursor.style.transform = `translate(${targetX}px, ${targetY}px) scale(${scale}) rotate(0deg)`;
                cursor.style.opacity = '1';
                requestAnimationFrame(animate);

            } else if (elapsed < durationEnter + durationClick + durationExit) {
                const exitProgress = (elapsed - durationEnter - durationClick) / durationExit;
                const t = easeInOutCubic(exitProgress);
                
                const currentX = targetX + (startX - targetX) * t;
                const currentY = targetY + (startY - targetY) * t;
                
                const opacity = 1 - t;

                cursor.style.transform = `translate(${currentX}px, ${currentY}px) scale(1) rotate(0deg)`;
                cursor.style.opacity = opacity.toString();
                
                requestAnimationFrame(animate);
            } else {
                isAnimating = false;
                cursor.style.opacity = '0';
            }
        };
        requestAnimationFrame(animate);
    };

    window.addEventListener('scroll', () => {
        const rect = featuresSection.getBoundingClientRect();
        const windowHeight = window.innerHeight;
        let progress = 1 - (rect.top / windowHeight);

        if (progress > 0.5 && !hasAnimatedIn) {
            hasAnimatedIn = true;
            runTimeBasedAnimation(); 
        }
    });
});

function copyInstallCommand(btnElement) {
    if (btnElement.classList.contains('is-copied')) return;
    
    const commandText = document.getElementById('install-command').innerText;
    navigator.clipboard.writeText(commandText).then(() => {
        btnElement.classList.add('is-copied');
        const textSpan = btnElement.querySelector('.btn-text');
        const icon = btnElement.querySelector('i') || btnElement.querySelector('svg');
        const originalText = textSpan.innerText;
        
        textSpan.innerText = 'Copied!';
        
        const copiedClasses = ['!bg-emerald-500/10', '!border-emerald-500', '!text-emerald-500', '!shadow-[0_0_12px_rgba(16,185,129,0.2)]'];
        btnElement.classList.add(...copiedClasses);
        
        if (icon) {
            icon.setAttribute('data-lucide', 'check');
            if (window.lucide) lucide.createIcons();
        }
        
        setTimeout(() => {
            textSpan.innerText = originalText;
            btnElement.classList.remove(...copiedClasses);
            btnElement.classList.remove('is-copied');
            
            const currentIcon = btnElement.querySelector('svg') || btnElement.querySelector('i');
            if (currentIcon) {
                currentIcon.setAttribute('data-lucide', 'copy');
                if (window.lucide) lucide.createIcons();
            }
        }, 5000);
    });
}

// ============ CUSTOM LANGUAGE SELECTOR SYNC & GOOGLE TRANSLATE ============
// Immediate anti-reset cookie sync for page reloads
(function restoreLanguageCookieImmediately() {
    const saved = localStorage.getItem('platinum_lang');
    if (saved && saved !== 'en') {
        const domain = window.location.hostname;
        document.cookie = `googtrans=/en/${saved}; path=/;`;
        if (domain && domain !== 'localhost' && !domain.includes('127.0.0.1')) {
            document.cookie = `googtrans=/en/${saved}; path=/; domain=${domain};`;
            document.cookie = `googtrans=/en/${saved}; path=/; domain=.${domain};`;
        }
    }
})();

function initCustomLanguageSelector() {
    // ---- Aggressive Google Translate banner killer ----
    const killGoogleBanner = () => {
        // Force body top position
        document.body.style.setProperty('top', '0', 'important');
        document.body.style.setProperty('position', 'static', 'important');

        // Remove injected banner iframes
        document.querySelectorAll(
            '.goog-te-banner-frame, iframe.skiptranslate, .skiptranslate:not(.notranslate), #goog-gt-tt'
        ).forEach(el => {
            if (el.tagName === 'IFRAME' || el.id === 'goog-gt-tt') {
                el.style.setProperty('display', 'none', 'important');
                el.style.setProperty('height', '0', 'important');
            }
        });

        // Reset any top margin/padding Google injects on html/body
        const html = document.documentElement;
        if (parseInt(html.style.marginTop) > 0 || parseInt(html.style.top) > 0) {
            html.style.setProperty('margin-top', '0', 'important');
            html.style.setProperty('top', '0', 'important');
        }
        if (parseInt(document.body.style.top) > 0) {
            document.body.style.setProperty('top', '0', 'important');
        }
    };

    // Run immediately and observe DOM mutations
    killGoogleBanner();
    const bannerObserver = new MutationObserver(killGoogleBanner);
    bannerObserver.observe(document.body, { childList: true, subtree: true, attributes: true, attributeFilter: ['style', 'class'] });

    // ---- Cookie helpers ----
    const setGoogleTransCookie = (lang) => {
        const domain = window.location.hostname;
        // Clear existing
        ['/', window.location.pathname].forEach(path => {
            document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path};`;
            if (domain && domain !== 'localhost' && !domain.includes('127.0.0.1')) {
                document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path}; domain=${domain};`;
                document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path}; domain=.${domain};`;
            }
        });

        if (lang && lang !== 'en') {
            document.cookie = `googtrans=/en/${lang}; path=/;`;
            if (domain && domain !== 'localhost' && !domain.includes('127.0.0.1')) {
                document.cookie = `googtrans=/en/${lang}; path=/; domain=${domain};`;
            }
        }
    };

    const getCookieLang = () => {
        const m = document.cookie.match(/(^|;)\s*googtrans=([^;]*)/);
        if (m && m[2]) {
            const p = m[2].split('/').filter(Boolean);
            return p.length > 1 ? p[p.length - 1] : null;
        }
        return null;
    };

    // ---- Initialize each wrapper on the page ----
    const wrappers = document.querySelectorAll('.custom-lang-wrapper');
    if (!wrappers.length) return;

    wrappers.forEach(langWrapper => {
        const customLangSelector = langWrapper.querySelector('#custom-lang-selector') || document.getElementById('custom-lang-selector');
        const langBtn = langWrapper.querySelector('#lang-selector-btn') || langWrapper.querySelector('.language-selector');
        const langMenu = langWrapper.querySelector('#lang-dropdown-menu') || langWrapper.querySelector('.lang-dropdown-menu');
        const langDisplayText = langWrapper.querySelector('#lang-display-text') || langWrapper.querySelector('.lang-text');

        if (!customLangSelector || !langBtn || !langMenu) return;

        // Build dropdown options from <select>
        langMenu.innerHTML = '';
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

        // Create dynamic liquid glass blob element inside dropdown
        let blob = langMenu.querySelector('.lang-dropdown-blob');
        if (!blob) {
            blob = document.createElement('div');
            blob.className = 'lang-dropdown-blob';
            langMenu.appendChild(blob);
        }

        let lastY = 0;
        let squishTimer = null;
        const options = langMenu.querySelectorAll('.lang-option');

        const moveBlobTo = (opt, animateSquish = true) => {
            if (!opt) return;
            const left = opt.offsetLeft;
            const top = opt.offsetTop;
            const width = opt.offsetWidth;
            const height = opt.offsetHeight;

            if (squishTimer) {
                clearTimeout(squishTimer);
                squishTimer = null;
            }

            blob.style.left = `${left}px`;
            blob.style.top = `${top}px`;
            blob.style.width = `${width}px`;
            blob.style.height = `${height}px`;
            blob.style.opacity = '1';

            if (animateSquish && lastY !== 0) {
                const delta = top - lastY;
                if (Math.abs(delta) > 4) {
                    if (delta > 0) {
                        blob.style.borderRadius = '45% 45% 55% 55% / 55% 55% 45% 45%';
                    } else {
                        blob.style.borderRadius = '55% 55% 45% 45% / 45% 45% 55% 55%';
                    }
                    blob.style.transform = `scaleY(${1 + Math.min(Math.abs(delta) * 0.005, 0.22)}) scaleX(${1 - Math.min(Math.abs(delta) * 0.003, 0.12)})`;
                    squishTimer = setTimeout(() => {
                        blob.style.borderRadius = '9999px';
                        blob.style.transform = 'scale(1)';
                        squishTimer = null;
                    }, 220);
                } else {
                    blob.style.borderRadius = '9999px';
                    blob.style.transform = 'scale(1)';
                }
            } else {
                blob.style.borderRadius = '9999px';
                blob.style.transform = 'scale(1)';
            }
            lastY = top;
        };

        options.forEach(opt => {
            opt.addEventListener('mouseenter', () => {
                moveBlobTo(opt, true);
            });
        });

        langMenu.addEventListener('mouseleave', () => {
            if (squishTimer) {
                clearTimeout(squishTimer);
                squishTimer = null;
            }
            blob.style.opacity = '0';
            blob.style.transform = 'scale(0.8)';
            blob.style.borderRadius = '9999px';
            lastY = 0;
        });

        // Toggle dropdown open/close
        langBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            // Close all other wrappers first
            document.querySelectorAll('.custom-lang-wrapper.active').forEach(w => {
                if (w !== langWrapper) w.classList.remove('active');
            });
            const isActive = langWrapper.classList.toggle('active');
            if (isActive) {
                setTimeout(() => {
                    const selectedOpt = langMenu.querySelector('.lang-option.selected') || options[0];
                    if (selectedOpt) moveBlobTo(selectedOpt, false);
                }, 40);
            }
        });

        // Click option in dropdown
        langMenu.addEventListener('click', (e) => {
            const optDiv = e.target.closest('.lang-option');
            if (optDiv) {
                const val = optDiv.dataset.value;
                customLangSelector.value = val;
                customLangSelector.dispatchEvent(new Event('change'));
                langWrapper.classList.remove('active');
            }
        });

        const updateUI = () => {
            const val = customLangSelector.value;
            const selectedOpt = customLangSelector.options[customLangSelector.selectedIndex];
            if (selectedOpt && langDisplayText) {
                langDisplayText.textContent = selectedOpt.textContent;
            }
            langMenu.querySelectorAll('.lang-option').forEach(opt => {
                opt.classList.toggle('selected', opt.dataset.value === val);
            });
            const selectedOptDiv = langMenu.querySelector('.lang-option.selected');
            if (selectedOptDiv) {
                moveBlobTo(selectedOptDiv, false);
            }
        };

        // On language change
        customLangSelector.addEventListener('change', (e) => {
            const lang = e.target.value;
            updateUI();

            if (lang === 'en') {
                // ENGLISH: Clear cookie + localStorage, deactivate translation cleanly without reload
                setGoogleTransCookie('en');
                localStorage.setItem('platinum_lang', 'en');

                document.documentElement.classList.remove('translated-ltr', 'translated-rtl');

                const gCombo = document.querySelector('.goog-te-combo');
                if (gCombo) {
                    gCombo.selectedIndex = 0;
                    gCombo.value = '';
                    gCombo.dispatchEvent(new Event('change'));
                }

                // Try clicking restore button in Google Translate frames if present
                document.querySelectorAll('iframe.goog-te-banner-frame, iframe.skiptranslate, iframe[id^=":"]').forEach(iframe => {
                    try {
                        const doc = iframe.contentWindow?.document || iframe.contentDocument;
                        if (doc) {
                            const btn = doc.querySelector('button[id*="restore"], .goog-close-link, #\\:1\\.restore');
                            if (btn) btn.click();
                        }
                    } catch (err) {}
                });
                return;
            }

            // Non-English: set cookie + persist, then trigger Google Translate
            setGoogleTransCookie(lang);
            localStorage.setItem('platinum_lang', lang);

            const triggerTranslation = () => {
                const gCombo = document.querySelector('.goog-te-combo');
                if (gCombo) {
                    const optExists = Array.from(gCombo.options).some(o => o.value === lang);
                    if (optExists) {
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
                    if (triggerTranslation() || ++attempts > 30) clearInterval(retry);
                }, 150);
            }
        });

        // Init UI display on load
        updateUI();
    });

    // ---- Close all dropdowns on outside click ----
    document.addEventListener('click', (e) => {
        document.querySelectorAll('.custom-lang-wrapper.active').forEach(w => {
            if (!w.contains(e.target)) w.classList.remove('active');
        });
    });

    // ---- Auto-restore saved language on page load ----
    const savedLang = localStorage.getItem('platinum_lang');
    const cookieLang = getCookieLang();
    const targetLang = (savedLang && savedLang !== 'en') ? savedLang : cookieLang;

    if (targetLang && targetLang !== 'en') {
        setGoogleTransCookie(targetLang);

        const allSelectors = document.querySelectorAll('#custom-lang-selector');
        allSelectors.forEach(sel => {
            const optExists = [...sel.options].some(o => o.value === targetLang);
            if (optExists) {
                sel.value = targetLang;
            }
        });

        document.querySelectorAll('.custom-lang-wrapper').forEach(w => {
            const display = w.querySelector('.lang-text') || w.querySelector('#lang-display-text');
            const menu = w.querySelector('.lang-dropdown-menu');
            const sel = w.querySelector('#custom-lang-selector') || document.getElementById('custom-lang-selector');
            const opt = sel ? [...sel.options].find(o => o.value === targetLang) : null;
            if (display && opt) display.textContent = opt.textContent;
            if (menu) {
                menu.querySelectorAll('.lang-option').forEach(o => {
                    o.classList.toggle('selected', o.dataset.value === targetLang);
                });
            }
        });

        let attempts = 0;
        const autoSet = setInterval(() => {
            const googleSelect = document.querySelector('.goog-te-combo');
            if (googleSelect) {
                const optExists = Array.from(googleSelect.options).some(o => o.value === targetLang);
                if (optExists) {
                    googleSelect.value = targetLang;
                    googleSelect.dispatchEvent(new Event('change'));
                    clearInterval(autoSet);
                }
            }
            if (++attempts > 60) clearInterval(autoSet);
        }, 150);
    }
}




