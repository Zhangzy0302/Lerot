import SwiftUI

struct CwiHAkmeajHomePage: View {
  @EnvironmentObject var ciwaNavi: NavigationManager

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        MwunzArtTitle(title: "LEROT", width: 105)
        Spacer()
        Circle().fill(.white.opacity(0.4)).frame(width: 44)
          .overlay {
            Image("cponlzna_record_hisotry")
              .resizable()
              .frame(width: 18, height: 18)
          }.onTapGesture {
            ciwaNavi.push(VeulaNwiAppRoute.rinxbmRecordHistory)
          }

      }.padding(.horizontal, 20)
        .padding(.top, 6)
      ZStack {
        SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 28)
          .fill(
            LinearGradient(
              colors: [
                Color(red: 1, green: 158 / 255, blue: 240 / 255),
                .white,
              ], startPoint: .topTrailing, endPoint: .bottomLeading)
          )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 15)
          .fill(
            LinearGradient(
              colors: [
                LerWifaTheme.Color.mainPurple,
                .white,
              ], startPoint: .topTrailing, endPoint: .bottomLeading)
          )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.top, 15)
        CwiaAkweRecordCard()
      }.padding(.horizontal, 20)
        .padding(.bottom, 10)
        .padding(.top, 6)
    }.navigationBarHidden(true)
  }

  private struct CwiaAkweRecordCard: View {

    @State var wilmaxDates: [Date] = []
    @State private var cwqoiaDateList: [(day: Int, weekday: String)] = []
    @EnvironmentObject var cwaiaRecord: JflawhPracRecordViewModel
      
      
      @State var cwqoHaskTodayRecord: [JflawhPracRecord] = []

    func datesFromToday(days: Int) -> [Date] {
      let calendar = Calendar.current
      let today = calendar.startOfDay(for: Date())

      return (0...days).compactMap {
        calendar.date(byAdding: .day, value: $0, to: today)
      }
    }

    func dayAndWeekday(from date: Date) -> (day: Int, weekday: String) {
      let calendar = Calendar.current
      let day = calendar.component(.day, from: date)

      let weekdayIndex = calendar.component(.weekday, from: date)
      let weekdays = ["SUN", "MON", "Tue", "Wed", "Thu", "Fri", "Sat"]

      return (day, weekdays[weekdayIndex - 1])
    }

    var body: some View {
      VStack(spacing: 0) {
        HStack {
          ForEach(cwqoiaDateList, id: \.self.day) { dayInfo in
            VStack(spacing: 6) {
              Text(dayInfo.weekday)
                .font(LerWifaTheme.LerotFont.baigo(16))
                .foregroundColor(.white)
                .padding(2)
              Text("\(dayInfo.day)")
                .font(LerWifaTheme.LerotFont.neoneon(16))
                .foregroundColor(.white)
            }
          }
        }.padding(.bottom, 18)
          if(!cwqoHaskTodayRecord.isEmpty){
              VStack(spacing: 0) {
                  ZStack {
                      KalfwalxImage(KalfwalxImageUrl: cwqoHaskTodayRecord[0].jflawhPracRecordImage, KalfwalxHeight: .infinity)
                          .cornerRadius(30)
                    HStack(spacing: 10) {
                      Text("1h 30min")
                        .font(LerWifaTheme.LerotFont.baigo(12))
                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                        .padding(10)
                        .background(
                          RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                        )
                      Text("Status: 4 points")
                        .font(LerWifaTheme.LerotFont.baigo(12))
                        .foregroundColor(LerWifaTheme.Color.mainYellow)
                        .padding(10)
                        .background(
                          RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                        )
                    }
                  }.frame(maxWidth: .infinity, maxHeight: .infinity)
                Text(
                    cwqoHaskTodayRecord[0].jflawhPracRecordText
                )
                .font(LerWifaTheme.LerotFont.miSans(12))
                .foregroundColor(.white)
                .padding(.top, 12)
              }
          }else{
              LeraoNoRecord()
          }
        

      }.padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
          RoundedRectangle(cornerRadius: 30)
            .fill(.black)

        ).padding(.top, 32)
        .onAppear {
          wilmaxDates = datesFromToday(days: 6)
          cwqoiaDateList = wilmaxDates.map {
            dayAndWeekday(from: $0)
          }
            cwqoHaskTodayRecord = cwaiaRecord.getTodayRecord()
        }
    }
  }
    
    private struct LeraoNoRecord: View {
        
        @EnvironmentObject var cwaiNavi: NavigationManager
        var body: some View {
            VStack{
                VStack{
                    NvawildNoData(nwaiTopPadding: 90, nwaiBottomPadding: 0)
                    Text("Not recorded yet")
                        .font(LerWifaTheme.LerotFont.miSans(16))
                        .foregroundColor(.white.opacity(0.4))
                    
                }
                Spacer()
                UploadButton {
                    cwaiNavi.push(VeulaNwiAppRoute.potsnaRecordUpload)
                }.padding(.bottom, 50)
            }
        }
    }
    
    
}
private struct UploadButton: View {

    let action: () -> Void

    var body: some View {
        ZStack {
            buttonBackground
            buttonContent
            handIcon
        }
        .frame(width: 130, height: 40)
        .onTapGesture(perform: action)
    }
    
}

private extension UploadButton {

    var buttonBackground: some View {
        RoundedRectangle(cornerRadius: 66)
            .fill(Color.clear)
            .background(
                LerWifaTheme.Color.mainPurple
                    .opacity(0.2)
                    .cornerRadius(66)
            )
            .overlay(topInnerShadow)
            .overlay(bottomInnerShadow)
    }

    var topInnerShadow: some View {
        RoundedRectangle(cornerRadius: 66)
            .stroke(Color.white, lineWidth: 2)
            .blur(radius: 4)
            .offset(y: 2)
            .mask(RoundedRectangle(cornerRadius: 66))
    }

    var bottomInnerShadow: some View {
        RoundedRectangle(cornerRadius: 66)
            .stroke(Color.white, lineWidth: 2)
            .blur(radius: 4)
            .offset(y: -2)
            .mask(RoundedRectangle(cornerRadius: 66))
    }
}

private extension UploadButton {

    var buttonContent: some View {
        Text("Upload")
            .font(LerWifaTheme.LerotFont.baigo(16))
            .foregroundColor(.white)
    }
}

private extension UploadButton {

    var handIcon: some View {
        Image("cponlzna_hand_point")
            .resizable()
            .frame(width: 35, height: 35)
            .offset(x: 11, y: 12)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomTrailing
            )
    }
}
