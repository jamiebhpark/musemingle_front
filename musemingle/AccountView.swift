import SwiftUI


enum ActiveAlert: Identifiable {
    case logout, deleteAccount
    
    var id: Int {
        switch self {
        case .logout:
            return 1
        case .deleteAccount:
            return 2
        }
    }
}
struct AccountView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 추적하는 바인딩 변수
    @State private var activeAlert: ActiveAlert?
    
    
    var body: some View {
        VStack {
            Button(action: {
                activeAlert = .logout
            }) {
                Text("Sign Out")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.primary)
                    .cornerRadius(10)
            }
            
            Button(action: {
                activeAlert = .deleteAccount
            }) {
                Text("Delete Account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Account")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
        }
        .alert(item: $activeAlert) { item in
            switch item {
            case .logout:
                return Alert(title: Text("Are you sure you want to Sign Out?"),
                             primaryButton: .default(Text("Sign Out"), action: {
                    isLoggedIn = false // 로그아웃 처리 후 상태 변경
                }),
                             secondaryButton: .cancel())
            case .deleteAccount:
                return Alert(title: Text("Are you sure you want to delete your account?"),
                             message: Text("This action cannot be undone."),
                             primaryButton: .destructive(Text("Delete"), action: {
                    deleteAccount()
                }),
                             secondaryButton: .cancel())
            }
        }
    }
    
    // 계정 삭제 로직
    func getCurrentUserId(completion: @escaping (String?) -> Void) {
        let url = URL(string: "http://3.34.187.225/users/current_user")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // 필요한 경우 인증 토큰을 헤더에 추가
        // request.setValue("YOUR_AUTH_TOKEN", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let userId = jsonResponse["id"] as? String {
                        completion(userId)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching current user ID: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func deleteAccount() {
        getCurrentUserId { userId in
            guard let userId = userId else {
                // ID 가져오기 실패 처리
                return
            }
            
            let url = URL(string: "http://3.34.187.225/users/\(userId)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                    DispatchQueue.main.async {
                        isLoggedIn = false
                    }
                } else if let error = error {
                    print("Error deleting account: \(error)")
                }
            }.resume()
        }
    }
}
