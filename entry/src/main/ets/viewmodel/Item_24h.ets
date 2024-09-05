import {model_24h} from '../viewmodel/model_24h'
import {chooseImageAccordingWeather} from '../view/NowAreaComponent'
@Component
export struct Item_24h{
  ItemInfo:model_24h =new model_24h()
  icon_unide : string = chooseImageAccordingWeather(this.ItemInfo.text)

  build() {
    Column(){
      Text(this.ItemInfo.time)
        .fontSize(18)
      Text(`${this.icon_unide}`)
        .fontSize(40)
        .fontFamily('myfont')
      Text(this.ItemInfo.temp)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      Text(this.ItemInfo.windDir)
        .fontSize(18)
    }.height(150)
    .width(50)
    .justifyContent(FlexAlign.Center)
  }

}