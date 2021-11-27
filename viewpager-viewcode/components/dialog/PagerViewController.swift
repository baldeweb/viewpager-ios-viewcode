//
//  PagerViewController.swift
//  ViewPager-ViewCode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import UIKit
import SnapKit

open class PagerViewController: UIViewController, UIPageViewControllerDelegate {
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: containerView.frame.height)
        
        for i in 0..<pages.count {
            var page = pages[i]
            let dialog = PageViewController(
                icon: page.icon,
                titleText: page.title,
                descriptionText: page.description,
                titleActionButton: page.titleButton,
                actionButton: page.actionButton
            )!
            scrollView.addSubview(dialog.view)
            scrollView.subviews[i].frame = CGRect(
                x: view.frame.width * CGFloat(i),
                y: 0,
                width: containerView.frame.width,
                height: containerView.frame.height
            )
        }
        
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.backgroundColor = .white
        return pageControl
    }()
    
    private lazy var controlsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var buttonJump = UIButton()
    private lazy var buttonBefore = UIButton()
    private lazy var buttonNext = UIButton()
    private let maxDimmedAlpha: CGFloat = 0.7
    private var titleJumpButton: String! = ""
    private var currentPage: Int = 0
    open var pages: Array<PageModel>!
    
    init?(pages: Array<PageModel>, titleJumpButton: String) {
        super.init(nibName: nil, bundle: nil)
        self.pages = pages
        self.titleJumpButton = titleJumpButton
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViewComponents()
        setupConstraints()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentationView(
            viewTarget: self.dimmedView,
            duration: 0.2,
            startAlpha: 0,
            finalAlpha: self.maxDimmedAlpha,
            completion: {
            animatePresentationView(viewTarget: self.containerView, duration: 0.3, startAlpha: 0, finalAlpha: 1, completion: {})
        })
        containerView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
        setupNavigationButtonsStyle()
    }
    
    private func setupView() {
        self.buttonJump = JumpButton(context: self,
                                     title: titleJumpButton!,
                                     selector: #selector(actionJumpPressed)).build()
        
        self.buttonBefore = PageButton(context: self,
                                       title: "Anterior",
                                       selector: #selector(actionBeforePressed)).build()
        
        self.buttonNext = PageButton(context: self,
                                     title: "Próximo",
                                     selector: #selector(actionNextPressed)).build()
    }
    
    private func addViewComponents() {
        view.addSubview(dimmedView)
        
        containerView.addSubview(scrollView)
        
        controlsStackView.addArrangedSubview(buttonBefore)
        controlsStackView.addArrangedSubview(pageControl)
        controlsStackView.addArrangedSubview(buttonNext)
        
        containerView.addSubview(controlsStackView)
        
        containerView.addSubview(buttonJump)
        
        view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        dimmedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().inset(100)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.margins.equalTo(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(controlsStackView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.greaterThanOrEqualTo(0)
        }
        
        controlsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonJump.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(50)
        }
        
        buttonJump.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(46)
        }
    }
    
    private func setupNavigationButtonsStyle() {
        if currentPage == 0 {
            disableBeforeButton()
        }
    }
    
    private func disableBeforeButton() {
        self.buttonBefore.buttonDisabled()
        self.buttonNext.buttonEnabled()
    }
    
    private func disableNextButton() {
        self.buttonBefore.buttonEnabled()
        self.buttonNext.buttonDisabled()
    }
    
    private func enableNavigationsButton() {
        self.buttonBefore.buttonEnabled()
        self.buttonNext.buttonEnabled()
    }
    
    @objc private func actionJumpPressed() {
        animateDismissView(context: self, viewTarget: self.view, duration: 0.3, startAlpha: maxDimmedAlpha, finalAlpha: 0)
    }
    
    @objc private func actionBeforePressed() {
        currentPage -= 1
        
        enableNavigationsButton()
        scrollView.setContentOffset(CGPoint(x: Int(view.bounds.width) * currentPage, y: 0), animated: true)
        
        let isFirstPage = currentPage == 0
        if isFirstPage {
            disableBeforeButton()
            return
        }
    }
    
    @objc private func actionNextPressed() {
        currentPage += 1
        
        enableNavigationsButton()
        scrollView.setContentOffset(CGPoint(x: Int(view.bounds.width) * currentPage, y: 0), animated: true)
        
        let isLastPage = currentPage == pages.count || (currentPage + 1) == pages.count
        if isLastPage {
            disableNextButton()
            return
        }
    }
}

extension PagerViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
        pageControl.currentPage = pageIndex
    }
}

extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        self.scrollRectToVisible(frame, animated: true)
    }
}
