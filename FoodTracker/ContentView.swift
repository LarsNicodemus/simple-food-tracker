import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
        var body: some View {
            
            TabView(selection: $selection) {
                Tab("Start", systemImage: "house.fill", value: 0) {
                    EntryListView()
                }
                

                Tab("Dashboard", systemImage: "chart.pie.fill", value: 1) {
                    DashboardView()
                }
            }
                    
        }
    }


#Preview {
    ContentView()
}
