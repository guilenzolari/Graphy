import SwiftUI

struct QuestionButton: View {
    
    @State private var isPresentingAboutSheet = false
    
    var body: some View {
        VStack {
            
            Image(
                systemName: "questionmark.circle"
            )
            .resizable()
            .frame(
                width: 22,
                height: 22
            )
            .fontWeight(
                .regular
            )
            .foregroundColor(
                .accentColor
            )
            .onTapGesture {
                isPresentingAboutSheet = true
            }
            
        }.sheet(
            isPresented: Binding<Bool>(
                get: {
                    isPresentingAboutSheet
                },
                set: {
                    _ in
                }
            ),
            
            content: {
                QuestionView(
                    isPresentingAboutSheet: $isPresentingAboutSheet
                )
                .presentationDetents(
                    [.fraction(
                        0.60
                    )]
                )
                .onDisappear(
                    perform: {
                        isPresentingAboutSheet = false
                    }
                )
            })
    }
}

struct QuestionView: View {
    @Binding var isPresentingAboutSheet: Bool
    
    let subtitleItems = [
        SubtitleItem(
            iconName: "location.square.fill",
            iconColor: .accentColor,
            title: "Seta",
            description: "Nó onde se inicia a busca."
        ),
        SubtitleItem(
            iconName: "square.fill",
            iconColor: Color(
                .systemGray4
            ),
            title: "Quadrado cinza",
            description: "Nó não visitado."
        ),
        SubtitleItem(
            iconName: "square.fill",
            iconColor: .accentColor,
            title: "Quadrado azul",
            description: "Nó após ser visitado."
        ),
        SubtitleItem(
            iconName: "circle.square.fill",
            iconColor: .green,
            title: "Quadrado com círculo",
            description: "Nó que compõe o caminho."
        ),
        SubtitleItem(
            iconName: "flag.square.fill",
            iconColor: .red,
            title: "Bandeira",
            description: "Nó alvo (aquele que está sendo procurado)."
        ),
        SubtitleItem(
            iconName: "minus.square.fill",
            iconColor: .primary,
            title: "Traço",
            description: "Barreira (nó não existente no grafo)."
        )
    ]
    
    
    var body: some View {
        VStack (alignment: .leading, content: {
            
            HStack(alignment: .center, content: {
                Spacer()
                Text(
                    "Legenda"
                )
                .foregroundColor(
                    .primary
                )
                .multilineTextAlignment(
                    .center
                )
                .font(
                    .body
                )
                .fontWeight(
                    .bold
                )
                Spacer()
                Text(
                    "OK"
                )
                .font(
                    .body
                )
                .foregroundColor(
                    .accentColor
                )
                
                .fontWeight(
                    .semibold
                )
                .onTapGesture {
                    isPresentingAboutSheet = false
                }
            }).padding(.bottom, 16)
            
            
            VStack (alignment: .leading,
                    content: {
                ForEach(
                    subtitleItems,
                    id: \.title
                ) { item in
                    SubtitileView(
                        iconName: item.iconName,
                        iconColor: item.iconColor,
                        title: item.title,
                        description: item.description
                    ).padding(
                        .bottom,
                        16
                    )
                }
                
                
            })
            
        }).padding()
    }
}

#Preview {
    QuestionView(
        isPresentingAboutSheet: .constant(
            true
        )
    )
}

import SwiftUI

struct SubtitileView: View {
    var iconName: String
    var iconColor: Color
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .top,
               content: {
            Image(
                systemName: iconName
            )
            .resizable()
            .frame(
                width: 36,
                height: 36
            )
            .foregroundColor(
                iconColor
            )
            .padding(
                .trailing,
                10
            )
            VStack(
                alignment: .leading
            ) {
                Text(
                    title
                )
                .font(
                    .system(
                        size: 17
                    )
                )
                .fontWeight(
                    .bold
                )
                .padding(
                    .bottom,
                    0
                )
                Text(
                    description
                )
                .font(
                    .system(
                        size: 17
                    )
                )
                .foregroundColor(
                    .secondary
                )
                .multilineTextAlignment(.trailing)
            }
        })
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SubtitileView(
            iconName: "location.square",
            iconColor: Color(
                .systemGray3
            ),
            title: "Seta vazia",
            description: "Nó onde se inicia a busca."
        )
    }
}

struct SubtitleItem {
    var iconName: String
    var iconColor: Color
    var title: String
    var description: String
}
