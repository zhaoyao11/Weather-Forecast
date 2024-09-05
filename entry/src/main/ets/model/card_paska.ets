import {NowWeather} from '../viewmodel/NowWeather'
import {currentdayweather, getWeatherUtil} from '../util/GetWeatherUtil'

@Component

export struct card_paska{
  code:string = ''
  @State paska:string = ''
// nowWeatherData:NowWeather = new NowWeather()

  @Builder descriptionBuilder(){
    Text('hPa')
      .fontColor(Color.Gray)
      .fontSize(12)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height('100%')
  }

  aboutToAppear(): void {
    new getWeatherUtil().getNowWeather(this.code)
      .then((data)=>{
        this.paska = data.now.pressure
        console.log('小组件数据paska:'+this.paska)
      })

  }


  build() {
    Row(){
      Column(){
        Text('气压')
          .fontSize(16)
          .margin({bottom:10})

        Text(this.paska)
          .fontWeight(FontWeight.Bold)
          .fontSize(22)
      }.margin({left:10})

      Gauge({value:1,max:1}){
        Column(){
          Image($r('app.media.paska'))
            .width(20)
            .margin({top:15})
        }.width('100%').height('100%')

      }
      .colors('#00bbff')
      .startAngle(210)
      .endAngle(150)
      .strokeWidth(5)
      .width(50)
      .height(50)
      .description(this.descriptionBuilder)
      .margin({left:40})


    }.width(155)
    .margin({top:20,left:-10})
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius(15)
  }
}