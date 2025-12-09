internal import SwiftUI

struct EditClubView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @Environment(\.dismiss) var dismiss

    @State var club: Club

    var body: some View {
        Form {
            Section(header: Text("Атауы")) {
                TextField("Атауы", text: $club.title)
            }

            Section(header: Text("Сипаттама")) {
                TextField("Сипаттама", text: $club.description)
            }

            Section(header: Text("Өтетін жер / Күні")) {
                TextField("Өтетін орын", text: $club.place)
                TextField("Күні", text: $club.weeklyDay)

                DatePicker("Басталу уақыты",
                           selection: $club.startTime,
                           displayedComponents: .hourAndMinute)
            }

            Section(header: Text("Сыйымдылық")) {
                TextField("Саны", value: $club.capacity, formatter: NumberFormatter())
            }

            Button("Өзгерістерді сақтау") {
                clubVM.updateClub(club)
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .navigationTitle("Үйірмені өзгерту")
    }
}
