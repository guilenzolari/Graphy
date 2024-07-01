import SwiftUI

struct AboutButton: View {

    @State private var isPresentingAboutSheet = false
    
    var body: some View {
        VStack {
            
            Image(systemName: "ellipsis.circle")
                .resizable()
                .frame(width: 22, height: 22)
                .fontWeight(.medium)
                .foregroundColor(.accentColor)
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
                AboutView(isPresentingAboutSheet: $isPresentingAboutSheet).presentationDetents([.fraction(0.6)])
                    .onDisappear(
                    perform: { isPresentingAboutSheet = false
                    }
                )
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
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 41, height: 41)
                                .foregroundColor(.accentColor)
                                .padding(.trailing, 10)
                            VStack (alignment: .leading, content: {
                                Text("Sobre os autores")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 2)
                                Text("Carolina é uma estudante da Apple Developer Academy e de  Sistemas de Informação na Unicamp.")
                                    .font(.system(size: 17))
                                    .foregroundColor(.secondary)
                            })
                            
                        }
                        
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 41, height: 41)
                                .foregroundColor(.accentColor)
                                .padding(.trailing, 10)
                            Text("Guilherme é um estudante da Apple Developer Academy e de  Engenharia Química na Unicamp.")
                                .font(.system(size: 17))
                                .foregroundColor(.secondary)
                        }
                    }).padding(.top, 24)
                    HStack {
                        Spacer()
                        Text("Feito com 💙 by")
                            .foregroundColor(.secondary)
                        Link("Carolina", destination: URL(string: "https://br.linkedin.com/in/carolquiterio")!)
                            .foregroundColor(.blue)
                            .bold()
                            .padding(-4)
                        Text("and")
                            .foregroundColor(.secondary)
                        Link("Guilherme", destination: URL(string: "https://br.linkedin.com/in/guilherme-lenzolari")!)
                            .bold()
                            .padding(-4)
                        Spacer()
                    }.padding(.vertical)
                    Spacer()
                })
                .padding()
            })
        }
}

#Preview {
    AboutView(isPresentingAboutSheet: .constant(true))
}
