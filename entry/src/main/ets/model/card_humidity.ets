import {NowWeather} from '../viewmodel/NowWeather'
import {currentdayweather, getWeatherUtil} from '../util/GetWeatherUtil'
@Component

export struct card_humidity{
//  nowWeatherData:NowWeather = new NowWeather()
  code:string =''
 @State humidity:string = ''

  @Builder descriptionBuilder(){
    Text('潮湿')
      .fontColor(Color.Gray)
      .fontSize(8)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height('100%')
  }

  aboutToAppear(): void {
    new getWeatherUtil().getNowWeather(this.code)
      .then((data)=>{
        this.humidity = data.now.humidity
      })
    console.log('小组件数据humidity:'+this.humidity)
  }


  build() {
    Row(){
      Column(){
        Text('湿度')
          .fontSize(16)
          .margin({bottom:10})

        Text(this.humidity+'%')
          .fontWeight(FontWeight.Bold)
          .fontSize(22)
      }.margin({left:10})

      Gauge({value:Number(this.humidity),min:0,max:100}){
        Column(){
          Image($r('app.media.humidity'))
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
      .margin({left:35})


    }.width(155)
    .margin({top:20,left:-10})
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius(15)
  }
}