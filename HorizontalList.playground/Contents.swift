//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport


struct Poster: Identifiable {
    var id:Int

    static func arrayWith(size: Int) -> [Poster] {
        var arr = [Poster]()
        (0...size).forEach {
            arr.append(Poster(id: $0))
        }
        return arr
    }
}

struct HorizontalList: View {

    @State var posters = Poster.arrayWith(size: 100)

    var rows: [GridItem] = [
        GridItem(.fixed(10)),
    ]

    var body: some View {
        ScrollView {

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(posters) { poster in
                        Text("\(poster.id)")
                    }
                }
                .padding()
            }
            .frame(width: 200, height: 200, alignment: .leading)
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView(HorizontalList())

