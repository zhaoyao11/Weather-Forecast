import {NowWeather} from '../viewmodel/NowWeather'
import {currentdayweather, getWeatherUtil} from '../util/GetWeatherUtil'
@Component

export struct card_somatosensory{
  code:string = ''
 @State nowsomatosensory:string = ''
  // nowWeatherData:NowWeather = new NowWeather()


  @Builder descriptionBuilder(){
    Text('热')
      .fontColor(Color.Gray)
      .fontSize(12)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height('100%')
  }

  aboutToAppear(): void {
    new getWeatherUtil().getNowWeather(this.code)
      .then((data)=>{
        this.nowsomatosensory = data.now.feelsLike
        console.log('小组件数据feellike:'+this.nowsomatosensory)
      })
  }


  build() {
    Row(){
      Column(){
        Text('体感')
          .fontSize(16)
          .margin({bottom:10})

        Text(this.nowsomatosensory+'°')
          .fontWeight(FontWeight.Bold)
          .fontSize(22)
      }.margin({left:10})

      Gauge({value:Number(this.nowsomatosensory),min:-20,max:50}){
      }
      .colors([['#0066ff',0.5],['#00ff99',0.2],['#ffbb00',0.3]])
      .startAngle(210)
      .endAngle(150)
      .indicator({icon:$r('app.media.indicator'),space:20})
      .strokeWidth(5)
      .width(50)
      .height(50)
      .description(this.descriptionBuilder)
      .margin({left:45})


    }.width(155)
    .margin({top:20,left:-10})
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius(15)
  }
}