//
//  KakaoViewController.swift
//  Laboratory
//
//  Created by SeoJunYoung on 6/3/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import KakaoSDKUser

class KakaoViewController: UIViewController {
    
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.rx.tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.tryLogin()
            }
            .disposed(by: disposeBag)
    }
    
    func tryLogin() {
        print(#function)
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe { oauthToken in
                    print("Success")
                } onError: { error in
                    print(error)
                }
                .disposed(by: disposeBag)
        } else {
            print("Login not anvailable")
        }
    }
    
    func fetchMe() {
        UserApi.shared.rx.me()
            .subscribe { user in
//                user.id
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
}


//회원가입 및 로그인
//카카오 인가코드 전달 후 백엔드 서버에서 access token 받아오는 응답 (최초 로그인 아닐시에만)
//private String kakaoUserId;
//private String tokenType;
//private String accessToken;
//private int expiresIn;
//private String refreshToken;
//private int refreshTokenExpiresIn;
//private String scope;
//
//-> 이게 클라이언트에서 토큰을 받는 것임, 로그인 상태 유지를 위해 토큰을 들고 있어야함
//
//
//최초 로그인일시,
//private String kakaoUserId;
// 
//윤재성 — 오늘 오후 7:10
//HTTP - POST 메서드 요청
//
//private String kakaoUserId; -> 필수
//private String gender; // 0,1 로 받음 (남,여)
//private Integer age;
//private String interest; // 이 부분 기획분이랑 이야기를 해야할 것 같음 단일 선택인지, 복수 선택인지
//
//선택 입력 받고 Request ( 최초 로그인일시 회원가입 해야하기 때문)
//HTTP - GET 메서드 요청
//
//private String code; <- 쿼리스트링으로 전달
//윤재성 — 오늘 오후 7:20
//최초 로그인 아닐 시 :  4(요청) -> 1(응답) 끝
//최초 로그인 일 시 : 4(요청) - > 2(응답) -> 3(요청) -> 1(응답) 끝
