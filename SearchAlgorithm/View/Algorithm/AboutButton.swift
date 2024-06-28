import SwiftUI

struct AboutButton: View {

    @State private var isPresentingAboutSheet = false
    
    var body: some View {
        VStack {
            
            Image("IconPng")
                .resizable()
                .frame(width: 26, height: 26)
                .onTapGesture {
                    isPresentingAboutSheet = true
                }
        }.sheet(
            isPresented: Binding<Bool>(
                get: {
                    isPresentingAboutSheet },
                set: { _ in }
            ),
            
            content: {
                AboutView(isPresentingAboutSheet: $isPresentingAboutSheet)
            })
        .padding()
    }
}

struct AboutView: View {
    @Binding var isPresentingAboutSheet: Bool
    
    var body: some View {
        VStack (alignment: .center, content: {
            
            HStack(content: {
                Spacer()
                Text("Sobre")
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "xmark.circle")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 22, height: 22)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        isPresentingAboutSheet = false
                    }
            })
            .padding()
            
            VStack (alignment: .leading, content: {
                HStack {
                    Image("IconPng")
                        .resizable()
                        .frame(width: 46, height: 46)
                        .foregroundColor(.accentColor)
                        .padding(.trailing, 10)
                    VStack (alignment: .leading, content: {
                        Text("Sobre o App")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        
                        Text("Graphy é um aplicativo educacional desenhado para ajudar estudantes a entender algoritmos de busca.")
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                    })
                }
                VStack (alignment: .leading, content: {
                    Text("Sobre os autores")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 46, height: 46)
                            .foregroundColor(.accentColor)
                            .padding(.trailing, 10)
                        Text("Carolina é uma estudante da Apple Developer Academy e de  Sistemas de Informação na Unicamp.")
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                        
                    }
                    
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 46, height: 46)
                            .foregroundColor(.accentColor)
                            .padding(.trailing, 10)
                        Text("Guilherme é um estudante da Apple Developer Academy e de  Engenharia Química na Unicamp.")
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                    }
                }).padding(.top, 24)
                Spacer()
            })
            .padding()
        }
        )
    }
}

#Preview {
    AboutView(isPresentingAboutSheet: .constant(true))
}
