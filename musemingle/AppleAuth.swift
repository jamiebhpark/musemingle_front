
import AuthenticationServices
import SwiftKeychainWrapper

class AppleSignInManager: NSObject, ASAuthorizationControllerDelegate, ObservableObject {
    var loginStatusViewModel: LoginStatusViewModel

    init(loginStatusViewModel: LoginStatusViewModel) {
        self.loginStatusViewModel = loginStatusViewModel
    }

    func signIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: "userToken")

        let url = URL(string: "http://3.34.187.225/users/logout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Logout request error: \(error)")
                return
            }
            if let data = data {
                print("Logout response: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
            }
        }.resume()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let identityToken = appleIDCredential.identityToken,
               let identityTokenString = String(data: identityToken, encoding: .utf8) {
                print("Apple ID Token: \(identityTokenString)")
                sendTokenToServer(token: identityTokenString)
            } else {
                print("Failed to convert identity token.") // New Log
            }
        } else {
            print("Failed to get AppleIDCredential.") // New Log
        }
    }

    private func sendTokenToServer(token: String) {
        let url = URL(string: "http://3.34.187.225/auth/apple")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id_token": token])
        } catch let error {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error occurred while validating the token: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            

            if let data = data {
                print("Received data: \(data)")
                print("Login response: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                           let status = jsonResponse["status"] as? String, status == "success" {
                            
                            if let yourReceivedToken = jsonResponse["token"] as? String {
                                print("Received token from server: \(yourReceivedToken)")  // 추가
                                self.saveTokenToKeychain(yourReceivedToken)
                            }

                            DispatchQueue.main.async {
                                self.loginStatusViewModel.isLoggedIn = true
                            }
                        } else {
                            print("Login response JSON parsing failed or status was not 'success'.") // New Log
                        }
                    } catch let jsonError {
                        print("Error parsing JSON: \(jsonError)")
                    }
                } else {
                    print("Failed to authenticate with server due to invalid status code.")
                }
            }
        }.resume()
    }

    private func saveTokenToKeychain(_ token: String) {
        print("Attempting to save token to Keychain")
        let saveSuccessful = KeychainWrapper.standard.set(token, forKey: "userToken")
        if saveSuccessful {
            print("Token saved successfully in Keychain")
        } else {
            print("Failed to save token in Keychain")
        }
    }
}

class LoginStatusViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        checkLoginStatus()
    }

    func checkLoginStatus() {
        if let tokenFromKeychain = KeychainWrapper.standard.string(forKey: "userToken") {
            print("Token from Keychain: \(tokenFromKeychain)")
            validateToken(token: tokenFromKeychain)
        } else {
            print("Failed to get token from Keychain")
        }
    }

    func validateToken(token: String) {
        let url = URL(string: "http://3.34.187.225/apple_auth/validateToken")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("Sending token for validation: Bearer \(token)")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("Token validation response: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                           let status = jsonResponse["status"] as? String {
                            DispatchQueue.main.async {
                                self.isLoggedIn = status == "success"
                                if !self.isLoggedIn {
                                    KeychainWrapper.standard.removeObject(forKey: "userToken")
                                }
                            }
                        } else {
                            print("Token validation response JSON parsing failed or status was not 'success'.") // New Log
                        }
                    } catch let jsonError {
                        print("Error parsing JSON: \(jsonError)")
                    }
                }
            } else {
                print("Failed to validate token with invalid status code.")
            }
        }.resume()
    }
}
