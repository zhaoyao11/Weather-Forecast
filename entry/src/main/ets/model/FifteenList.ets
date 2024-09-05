import {fifteendays} from '../viewmodel/fifteendays'
import {chooseImageAccordingWeather} from '../view/NowAreaComponent'
@Component

export struct fifteenlist{
  month:number = 0//月份
  date:number = 0//日期
  day:number = 0//星期
  data:fifteendays = new fifteendays()
  curday:number = 0
  daydata = new Date()
 @Consume isOverMonth:boolean

  aboutToAppear(): void {
    if(this.date == 31){
        this.isOverMonth = true
    }
    this.curday = this.daydata.getDate()
    console.log("十五天出现curday:"+this.curday)
    console.log("十五天出现date:"+this.date)

  }

  build() {
    Column(){
      Text(this.curday==this.date?'今天':`星期${this.day}`)
        .fontSize(18)
        .margin({top:10})
      Text(`${this.month}月${this.date}日`)
        .fontSize(14)
        .margin({top:3})

      Text(`${this.data.windDirDay}`)
        .fontSize(10)
        .fontColor(Color.Gray)
        .margin({top:10})

        Text(chooseImageAccordingWeather(this.data.textDay))
          .fontSize(30)
          .fontFamily('myfont')
          .margin({top:20})


      Text(`${this.data.textDay}`)
        .fontSize(20)
        .margin({top:10})

      Text(`${this.data.tempMax}°`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({top:10})

      Text(`${this.data.tempMin}°`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({top:80})

      Text(chooseImageAccordingWeather(this.data.textNight))
        .fontSize(30)
        .fontFamily('myfont')
        .margin({top:10})

      Text(`${this.data.textNight}`)
        .fontSize(20)
        .margin({top:10})

      Text(`${this.data.windDirNight}`)
        .fontSize(10)
        .fontColor(Color.Gray)
        .margin({top:10})
    }.margin({top:35,left:15})

  }


}