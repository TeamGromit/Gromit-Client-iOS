//
//  Coordinator.swift
//  Gromit-client-iOS
//
//  Created by 김태성 on 2023/02/17.
//

import Foundation
import SwiftUI

// Page
// 일반 View

enum RootPage: String, Identifiable {
    case signInView, homeView, participatingListView, settingView
    var id: String {
        self.rawValue
    }
}

enum Page: String, Identifiable {
    case signInView, gitHubNameCheckView, inputUserNameView, challengeListView, participatingListView, homeView, settingView
    var id: String {
        self.rawValue
    }
}

// Sheet
// Modal과 흡사
// 호출 뷰와 상속 관계가 아닌..?
enum Sheet: String, Identifiable {
    case test
    var id: String {
        self.rawValue
    }
}

// FullScreenCover
// Modal과 흡사 FullScreen으로 호출 View를 모두 덮는다.
// 호출 뷰와 상속 관계가 아닌..?
enum FullScreenCover: String, Identifiable {
    case collectionListView, challengeCreateView, nickNameCreateView, checkGitUserPopup
    var id: String {
        self.rawValue
    }
}

enum AlertPopup: String, Identifiable {
    case test
    //case signInError, emptyUserName, isNotExistGitUser, isExistGitUser, isExistGromitUser, isNotExistGromitUser, requesetServerError
    var id: String {
        self.rawValue
    }
}

enum Popup: String, Identifiable {
    case isCheckGitUser, requestServerError, emptyUserName, isNotExistGitUser, isExistGromitUser, isNotExistGromitUser, signInError
    var id: String {
        self.rawValue
    }
}

// 객체의 변화를 감지하기 위해서는 ObservableObject 프로토콜을 채택해야한다.
class Coordinator: ObservableObject {
    // signInView, homeView, participatingListView, settingView
    // @Published @ObservableObject 프로토콜 준수해야 사용 가능
    @Published var sigInViewPath = NavigationPath()
    @Published var homeViewPath = NavigationPath()
    @Published var participatingListViewPath = NavigationPath()
    @Published var settingViewPath = NavigationPath()
    
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    @Published var alertPopup: AlertPopup?
    @Published var popup: Popup?
    
    @Published var isLoading: Bool = false
    @Published var isPopuping: Bool = false
    
    
    @AppStorage("rootPage") var rootPage: RootPage = .signInView
    
    var alertOKAction: (() -> Void)?
    var popupOKAction: (() -> Void)?
    var popupCancleAction: (() -> Void)?
    
    
    init() {
        print("Coordinator Init!! \(rootPage)")
    }
    
    
    func push(_ rootPage: RootPage, page: Page) {
        switch rootPage {
        case .signInView:
            sigInViewPath.append(page)
        case .homeView:
            homeViewPath.append(page)
        case .participatingListView:
            participatingListViewPath.append(page)
        case .settingView:
            settingViewPath.append(page)
        }
    }
    
    
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func present(alertPopup: AlertPopup, okAction: (() -> Void)? = nil) {
        self.alertPopup = alertPopup
        self.alertOKAction = okAction
    }
    
    
    func pop(_ rootPage: RootPage) {
        switch rootPage {
        case .signInView:
            if(sigInViewPath.isEmpty == false) {
                sigInViewPath.removeLast()
            }
        case .homeView:
            if(homeViewPath.isEmpty == false) {
                homeViewPath.removeLast()
            }
        case .participatingListView:
            if(participatingListViewPath.isEmpty == false) {
                participatingListViewPath.removeLast()
            }
        case .settingView:
            if(settingViewPath.isEmpty == false) {
                settingViewPath.removeLast()
            }
        }
    }
    func popToRoot() {
        switch rootPage {
        case .signInView:
            sigInViewPath.removeLast(sigInViewPath.count)
        case .homeView:
            homeViewPath.removeLast(homeViewPath.count)
        case .participatingListView:
            participatingListViewPath.removeLast(participatingListViewPath.count)
        case .settingView:
            settingViewPath.removeLast(settingViewPath.count)
        }
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func startLoading() {
        self.isLoading = true
    }
    
    func stopLoading() {
        self.isLoading = false
    }
    
    func openPopup(popup: Popup, okAction: (() -> Void)? = nil, cancleAction: (() -> Void)? = nil) {
        self.popup = popup
        popupOKAction = okAction
        popupCancleAction = cancleAction
        isPopuping = true
    }
    
    func closePopup() {
        isPopuping = false
    }
    
    //    @ViewBuilder
    //    func rootBuild() -> some View {
    //        switch rootPage {
    //        case .homeView
    //            HomeView()
    //        case .participatingListView
    //
    //        case .signInView:
    //            SignInView()
    //        }
    //    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .signInView:
            SignInView()
        case .gitHubNameCheckView:
            SearchGitUserView()
        case .inputUserNameView:
            InputUserNameView()
        case .challengeListView:
            TempChallengeListView()
        case .participatingListView:
            TempParticipatingListView()
        case .homeView:
            HomeView()
        case .settingView:
            SettingsView()
        }
        
    }
    
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .test:
            NavigationStack {
                CreationView()
            }
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .checkGitUserPopup: NavigationStack {
            //CheckGitUserPopup()
        }
        case .nickNameCreateView: NavigationStack {
            InputUserNameView()
        }
        case .challengeCreateView: NavigationStack {
            CreationView()
        }
        case .collectionListView: NavigationStack {
            CollectionListView()
        }
        }
    }
    
    //    func build(alert: AlertPopup) -> Alert {
    //        switch alert {
    //        case .signInError:
    //            return Alert(
    //                title: Text("로그인 실패!"),
    //                message: Text("애플리케이션 관리자에게 보고해주세요.")
    //                //               ,dismissButton: .default(Text("확인")) {
    //                //                    // 아래 코드 작동 안됨...
    //                //                    UserDefaults.standard.set(userNickname, forKey: "nickname")
    //                //                    guard let nickname = UserDefaults.standard.string(forKey: "nickname") else { return }
    //                //                    guard let githubName = UserDefaults.standard.string(forKey: "githubName") else { return }
    //                //                    guard let email = UserDefaults.standard.string(forKey: "email") else { return }
    //                //                    guard let provider = UserDefaults.standard.string(forKey: "provider") else { return }
    //                //                    print("userName: \(nickname) / githubName: \(githubName) / email: \(email) / provider: \(provider)")
    //                //                    inputUserNameViewModel.postSignUp(rNickname: nickname, rgithubName: githubName, rEmail: email, rProvider: provider)
    //                //                }
    //            )
    //        case .requesetServerError:
    //            return Alert(
    //                title: Text("로그인 실패!"),
    //                message: Text("애플리케이션 관리자에게 보고해주세요.")
    //            )
    //        case .emptyUserName:
    //            return Alert(title: Text("유저명을 입력해주세요!"))
    //        case .isNotExistGitUser:
    //            return Alert(title: Text("유저명 오류!") , message: Text("Git 유저명을 다시 한번 확인해주세요."))
    //        case .isExistGitUser:
    //            return Alert(title: Text("유저명 확인!"), message: Text("해당 유저로 등록하시겠습니까?"),
    //                         primaryButton: .default(Text("확인"), action: {
    //                if let alertOKAction = self.alertOKAction {
    //                    alertOKAction()
    //                }
    //            }), secondaryButton: .cancel(Text("취소"))
    //            )
    //        case .isExistGromitUser:
    //            return Alert(title: Text("유저명 중복!") , message: Text("다른 Gromit 유저명을 시도해주세요."))
    //        case .isNotExistGromitUser:
    //            return Alert(title: Text("유저명 확인!"), message: Text("해당 Gromit 유저명으로 등록하시겠습니까?"),
    //                         primaryButton: .default(Text("확인"), action: {
    //                if let alertOKAction = self.alertOKAction {
    //                    alertOKAction()
    //                }
    //            }), secondaryButton: .cancel(Text("취소"))
    //            )
    //        }
    //    }
    
    @ViewBuilder
    func buildLoadingView() -> some View {
        ZStack {
            Color(.darkGray)
                .opacity(0.5)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(3)
        }
    }
    
    // 이 방법 밖에 없나.....
    @ViewBuilder
    func buildPopupView() -> some View {
        
        switch self.popup{
        case .isCheckGitUser:
            GromitPopupView<GitProfileView>(buttonType: .twoButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                let userName = UserDefaults.standard.string(forKey: "githubUserName")
                let userImage = UserDefaults.standard.string(forKey: "githubImage")
                
                GitProfileView(userName: userName ?? "" , urlString: userImage ?? "")
            })
        case .isNotExistGitUser:
            GromitPopupView<MessageView>(buttonType: .oneButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "존재하지 않는 유저명!", message: "유저명을 확인 해주세요.")
            })
        case .requestServerError:
            GromitPopupView<MessageView>(buttonType: .oneButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "네트워크 서버 오류!", message: "관리자에게 오류를 보고해주세요!")
            })
        case .emptyUserName:
            GromitPopupView<MessageView>(buttonType: .oneButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "입력 오류!", message: "값을 입력해주세요!")
            })
        case .none:
            GromitPopupView<MessageView>(buttonType: .oneButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "", message: "")
            })
        case .isExistGromitUser:
            GromitPopupView<MessageView>(buttonType: .oneButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "유저명 중복!", message: "다른 유저명을 입력해주세요!")
            })
        case .isNotExistGromitUser:
            GromitPopupView<MessageView>(buttonType: .twoButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "유저명 확인!", message: "해당 유저명으로 가입하시겠습니까?")
            })
        case .signInError:
            GromitPopupView<MessageView>(buttonType: .twoButton, okDelegate: {
                if let popupOKAction = self.popupOKAction {
                    popupOKAction()
                }
            }, cancleDelegate: {
                if let popupCancleAction = self.popupCancleAction {
                    popupCancleAction()
                }
            }, content: {
                MessageView(title: "가입 오류!", message: "관리자에게 오류를 보고해주세요!")
            })
        }
    }
}
