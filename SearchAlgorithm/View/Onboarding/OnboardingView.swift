import SwiftUI

struct OnboardingView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    @Binding var onboardingCompleted: Bool
    
    var body: some View {
        VStack (alignment: .center, content: {
            Image("IconPng")
                .resizable()
                .frame(width: 60, height: 60)
            
            Text("Boas vindas ao Graphy")
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack (alignment: .leading, content: {
                HStack {
                    Image(systemName: "square.grid.3x3.square")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundColor(.blue)
                        .padding(.trailing, 10)
                    VStack (alignment: .leading, content: {
                        Text("Conheça algoritmos de busca")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        
                        Text("Visualize o funcionamento dos algoritmos e compare seus resultados.")
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                    })
                }.padding(.top, 34)
                Spacer()
            })
                NavigationLink(destination: viewFactory.homeView(), label:  {
                    HStack(alignment: .center, spacing: 4) {
                        Text("Começar")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(.blue)
                    .cornerRadius(40)
                }).simultaneousGesture(TapGesture().onEnded {
                    onboardingCompleted = true
                })
            
            
        }).padding(.horizontal, 36)
            .padding(.bottom, 36)
            .padding(.top, 140)
            
    }
}

#Preview {
    OnboardingView(onboardingCompleted: .constant(true))
}
