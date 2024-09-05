import {hours} from '../viewmodel/24h'
import {chooseImageAccordingWeather} from '../view/NowAreaComponent'
@Component

export struct list24hItem{

  data_24h:hours = new hours()

  currenthour:string = ''

  aboutToAppear(): void {
    this.currenthour = this.data_24h.fxTime.substring(11,16)
    console.log('截取之后的时刻为：'+this.currenthour)
  }

    build() {
      Column(){
        Text(this.data_24h.temp+'°')
          .fontSize(16)
          .margin({top:10,left:10})
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)

        Text(chooseImageAccordingWeather(this.data_24h.text))
          .fontFamily('myfont')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({top:15,left:10})

        Text(this.data_24h.windDir)
          .fontSize(13)
          .margin({top:10,left:10})
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)

        Text(this.currenthour)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({top:10,left:10})

      }.layoutWeight(1)
    }
}