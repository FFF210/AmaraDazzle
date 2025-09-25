// tab.js (교체본)
(function(){
    'use strict';

    // 특정 탭 컨테이너에 대해 초기화 및 제어 함수 생성
    function initTabContainer(tabContainer) {
        if (!tabContainer) return null;
        const tabId = tabContainer.id || null;
        const tabItems = Array.from(tabContainer.querySelectorAll('.tab-item'));

        // 가장 가까운 .tab-content 찾기 (tabContainer 다음 형제 또는 부모 내부)
        function findAssociatedTabContent() {
            // 1) 형제 요소 순차 탐색: tabContainer 다음 형제 중 .tab-content
            let el = tabContainer.nextElementSibling;
            while (el) {
                if (el.classList && el.classList.contains('tab-content')) return el;
                el = el.nextElementSibling;
            }
            // 2) 같은 부모 내부에서 찾기 (안 보이면)
            const parent = tabContainer.parentElement;
            if (parent) {
                const inParent = parent.querySelector('.tab-content');
                if (inParent) return inParent;
            }
            // 3) 전역에서 data-tab-container 속성으로 찾기 (옵션)
            if (tabId) {
                const globalMatch = document.querySelector(`.tab-content[data-tab-container="${tabId}"]`);
                if (globalMatch) return globalMatch;
            }
            // 없으면 document 전체의 첫 .tab-content 반환(대체)
            return document.querySelector('.tab-content');
        }

        const associatedContent = findAssociatedTabContent();

        function applyActiveTab(index, suppressEvent) {
            const idx = Number(index);
            if (isNaN(idx)) return;

            // tab-item 토글
            tabItems.forEach(item => {
                const itemIndex = item.dataset.tabIndex !== undefined ? parseInt(item.dataset.tabIndex, 10) : null;
                if (itemIndex === idx) item.classList.add('active');
                else item.classList.remove('active');
            });

            // 탭 패널 토글 (연관된 .tab-content 내부에서)
            if (associatedContent) {
                const panels = Array.from(associatedContent.querySelectorAll('.tab-panel'));
                panels.forEach(p => {
                    const pIndex = p.dataset.tab !== undefined ? parseInt(p.dataset.tab, 10) : null;
                    if (pIndex === idx) p.classList.add('active');
                    else p.classList.remove('active');
                });
            } else {
                // 전역 패널 토글(비권장, 하지만 보완)
                const panels = Array.from(document.querySelectorAll('.tab-panel'));
                panels.forEach(p => {
                    const pIndex = p.dataset.tab !== undefined ? parseInt(p.dataset.tab, 10) : null;
                    if (pIndex === idx) p.classList.add('active');
                    else p.classList.remove('active');
                });
            }

            if (!suppressEvent) {
                document.dispatchEvent(new CustomEvent('tabChanged', {
                    detail: {
                        tabId: tabId,
                        activeTabIndex: idx,
                        activeTabText: (tabContainer.querySelector(`.tab-item[data-tab-index="${idx}"]`) || {}).textContent || ''
                    }
                }));
            }
        }

        // 클릭 바인딩 (inline onclick이 있어도 안전하게 작동)
        tabItems.forEach(item => {
            if (!item.dataset._tabBound) {
                item.addEventListener('click', function(e){
                    e.preventDefault();
                    const idx = item.dataset.tabIndex !== undefined ? parseInt(item.dataset.tabIndex, 10) : null;
                    if (idx !== null) applyActiveTab(idx);
                });
                // 중복 바인딩 방지 마크
                item.dataset._tabBound = '1';
            }
        });

        // 초기 활성화 우선순위
        // 1) container.dataset.active, 2) .tab-item.active, 3) 첫 tab-item index
        let initialIndex = null;
        if (tabContainer.dataset && tabContainer.dataset.active !== undefined) {
            const v = parseInt(tabContainer.dataset.active, 10);
            if (!isNaN(v)) initialIndex = v;
        }
        if (initialIndex === null) {
            const activeItem = tabContainer.querySelector('.tab-item.active');
            if (activeItem && activeItem.dataset.tabIndex !== undefined) {
                initialIndex = parseInt(activeItem.dataset.tabIndex, 10);
            }
        }
        if (initialIndex === null && tabItems.length > 0) {
            initialIndex = tabItems[0].dataset.tabIndex !== undefined ? parseInt(tabItems[0].dataset.tabIndex, 10) : 0;
        }

        // 적용 (이때 이벤트는 발생시키지 않음)
        applyActiveTab(initialIndex, true);

        // 반환: 외부에서 제어 가능
        return {
            id: tabId,
            applyActiveTab,
            container: tabContainer,
            content: associatedContent
        };
    }

    // 모든 탭 컨테이너 초기화
    function initAllTabs() {
        const containers = Array.from(document.querySelectorAll('.tab-container'));
        const instances = {};
        containers.forEach(c => {
            const inst = initTabContainer(c);
            if (inst && inst.id) instances[inst.id] = inst;
        });
        // 전역 참조 보관 (선택적)
        window._tabInstances = instances;
    }

    // 공개 함수: 기존 호출 방식 호환(selectTab)
    window.selectTab = function(tabId, tabIndex) {
        if (!tabId) return;
        const container = document.getElementById(tabId);
        if (!container) return;
        // 이미 초기화된 인스턴스가 있으면 사용, 없으면 초기화 후 적용
        const inst = window._tabInstances && window._tabInstances[tabId] ? window._tabInstances[tabId] : initTabContainer(container);
        if (inst && typeof inst.applyActiveTab === 'function') inst.applyActiveTab(tabIndex);
    };

    // DOM 준비시 초기화
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAllTabs);
    } else {
        initAllTabs();
    }

})();
