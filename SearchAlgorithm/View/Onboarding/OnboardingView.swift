import SwiftUI

struct OnboardingView: View {
    let viewFactory = ViewFactory(
        dependencies: Dependencies.shared
    )
    @Binding var onboardingCompleted: Bool
    @State private var currentPage = 0
    
    var body: some View {
        VStack (alignment: .center,
                content: {
            TabView(
                selection: $currentPage
            ) {
                OnboardingViewPageZeroView().tag(
                    0
                )
                OnboardingViewPageOneView().tag(
                    1
                )
                OnboardingViewPageTwoView().tag(
                    2
                )
                OnboardingViewPageThreeView().tag(
                    3
                )
            }
            .tabViewStyle(
                PageTabViewStyle(
                    indexDisplayMode: .automatic
                )
            )
            .indexViewStyle(
                PageIndexViewStyle(
                    backgroundDisplayMode: .always
                )
            )
            
            NavigationLink(destination: viewFactory.homeView(),
                               label: {
                    HStack(
                        alignment: .center,
                        spacing: 4
                    ) {
                        Text(
                            "Começar"
                        )
                        .font(
                            .system(
                                size: 16
                            )
                        )
                        .fontWeight(
                            .bold
                        )
                        .foregroundColor(
                            .white
                        )
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding(
                        .horizontal,
                        20
                    )
                    .padding(
                        .vertical,
                        14
                    )
                    .background(
                        currentPage == 3 ? Color.blue : Color.gray
                    )
                    .cornerRadius(
                        40
                    )
                })
        }).padding(
            .horizontal,
            36
        )
        .padding(
            .bottom,
            36
        )
        .padding(
            .top,
            64
        )
        
    }
}

struct OnboardingItemView: View {
    
    let icon: String
    let title: String
    let description: String
    var body: some View {
        
        HStack {
            Image(
                systemName: icon
            )
            .resizable()
            .frame(
                maxWidth: 40,
                maxHeight: 43
            )
            .foregroundColor(
                .accentColor
            )
            .padding(
                .trailing,
                10
            )
            VStack (alignment: .leading,
                    content: {
                Text(
                    title
                )
                .font(
                    .system(
                        size: 17
                    )
                )
                .fontWeight(
                    .semibold
                )
                .padding(
                    .bottom,
                    2
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
            })
        }
    }
}

struct OnboardingViewPageZeroView: View {
    var body: some View {
        VStack {
            Image(
                "IconPng"
            )
            .resizable()
            .frame(
                width: 60,
                height: 60
            )
            
            Text(
                "Boas vindas ao Graphy"
            )
            .foregroundColor(
                .primary
            )
            .multilineTextAlignment(
                .center
            )
            .font(
                .largeTitle
            )
            .fontWeight(
                .bold
            )
            
            VStack (alignment: .leading,
                    content: {
                OnboardingItemView(
                    icon: "square.grid.3x3.square",
                    title: "Conheça algoritmos de busca",
                    description: "Visualize o funcionamento dos algoritmos e compare seus resultados."
                ).padding(
                    .top,
                    34
                )
                OnboardingItemView(
                    icon: "square.and.pencil",
                    title: "Personalize o algoritmo",
                    description: "Defina os pontos de inicio, fim, velocidade e mais informações dos algoritmos."
                ).padding(
                    .top,
                    16
                )
                Spacer()
            })
        }.padding(.top, 60)
    }
}

struct OnboardingViewPageTwoView: View {
    var body: some View {
        VStack {
            Text(
                "Como usar?"
            )
            .foregroundColor(
                .primary
            )
            .multilineTextAlignment(
                .center
            )
            .font(
                .system(
                    size: 28
                )
            )
            .fontWeight(
                .semibold
            )
            
            VStack {
                Spacer()
                OnboardingItemView(
                    icon: "chevron.up.chevron.down",
                    title: "Escolha um algoritmo para explorar o grafo",
                    description: "A exploração do grafo será representada por quadrados que vão sendo encontrados na visualização."
                ).padding(
                    .top,
                    16
                )
                OnboardingItemView(
                    icon: "speedometer",
                    title: "Defina a velocidade",
                    description: "Durante o funcionamento do algoritmo, escolha a velocidade da visualização da simulação."
                ).padding(
                    .top,
                    16
                )
                Spacer()
            }
        }
    }
}

struct OnboardingViewPageOneView: View {
    @State private var showMinusIcons = false

    var body: some View {
        VStack {
            Text("Grafos")
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .font(.system(size: 28))
                .fontWeight(.semibold)
            VStack {
                Spacer()
                Text("Grafos são estruturas de dados compostas por nós e arestas que conectam esses nós.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17))
                    .padding(.all, 16)
                
                VStack {
                    HStack {
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .leading))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .trailing))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                    }
                    
                    if showMinusIcons {
                        HStack {
                            Spacer()
                            Spacer()
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            
                            Spacer()
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            
                            Spacer()
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            Spacer()
                            Spacer()
                        }.padding(.vertical, 4)
                    }
                    
                    HStack {
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .leading))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .trailing))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                    }.padding(.vertical, 4)
                    
                    if showMinusIcons {
                        HStack {
                            Spacer()
                            Spacer()
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            
                            Spacer()
                            
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            Spacer()
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .rotationEffect(.degrees(90))
                                .transition(.move(edge: .top))
                            Spacer()
                            Spacer()
                        }.padding(.vertical, 4)
                    }
                    
                    HStack {
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .leading))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                        if showMinusIcons {
                            Image(systemName: "minus")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding(-4)
                                .transition(.move(edge: .trailing))
                        }
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, showMinusIcons ? -4 : 4)
                    }
                }
                
                Spacer()
            }
            .onTapGesture {
                withAnimation {
                    showMinusIcons.toggle()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showMinusIcons = true
                    }
                }
            }
            Spacer()
        }
    }
}


struct OnboardingViewPageThreeView: View {
    var body: some View {
        VStack {
            Text(
                "Conheça os diferentes tipos de nós"
            )
            .foregroundColor(
                .primary
            )
            .multilineTextAlignment(
                .center
            )
            .font(
                .system(
                    size: 28
                )
            )
            .fontWeight(
                .semibold
            )
            VStack (alignment: .leading,
                    content: {
                Spacer()
                SubtitileView(
                    iconName: "location.square.fill",
                    iconColor: .accentColor,
                    title: "Seta",
                    description: "Nó onde se inicia a busca."
                )
                .padding(
                    .bottom
                )
                .padding(
                    .top,
                    36
                )
                SubtitileView(
                    iconName: "square.fill",
                    iconColor: .primary,
                    title: "Quadrado primário",
                    description: "Obstáculo no grafo (nó inexistente)."
                )
                .padding(
                    .bottom
                )
                SubtitileView(
                    iconName: "circle.square.fill",
                    iconColor: .green,
                    title: "Quadrado com circulo",
                    description: "Nó que compõe o caminho final."
                )
                .padding(
                    .bottom
                )
                SubtitileView(
                    iconName: "flag.square.fill",
                    iconColor: .green,
                    title: "Quadrado com bandeira",
                    description: "Nó que está sendo procurado."
                )
                .padding(
                    .bottom
                )
                Spacer()
            })
        }
    }
}

#Preview {
    OnboardingView(
        onboardingCompleted: .constant(
            false
        )
    )
}
