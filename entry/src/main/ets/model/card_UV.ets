import {daily}from '../viewmodel/daily'
import {currentdayweather, getWeatherUtil} from '../util/GetWeatherUtil'
@Component

export struct card_UV{
  code:string = ''
  @State uvIndex:string = ''

  @State uv_level:string = ''
//  @State uv_number :number = 0

  @Builder descriptionBuilder(){
    Text('UV')
      .fontColor(Color.Gray)
      .fontSize(12)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height('100%')
  }

  aboutToAppear(): void {
    new getWeatherUtil().getWeather(this.code)
      .then((data)=>{
        this.uvIndex = data.daily[0].uvIndex
        console.log('小组件原数据uv:'+data.daily[0].uvIndex)
        console.log('小组件数据uv:'+this.uvIndex)
        this.uv_level = judgeUvLevel(this.uvIndex)
        console.log("uv_level源数据:"+this.uvIndex)
        console.log("uv_level:"+this.uv_level)
      })


  }

  build() {
    Row(){
      Column(){
        Text('紫外线')
          .fontSize(16)
          .margin({bottom:10})

        Text(this.uv_level)
          .fontWeight(FontWeight.Bold)
          .fontSize(22)
      }.margin({left:10})


      Gauge({value:Number(this.uvIndex),min:0,max:12}){
        Column(){
          Text(this.uvIndex)
            .fontWeight(FontWeight.Medium)
            .width('62%')
            .fontColor("#ff182431")
            .textAlign(TextAlign.Center)
            .margin({ top: '35%' })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)

        }.width('100%').height('100%')

      }
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

function judgeUvLevel(value:string){
  if(value==='0'||value==='1'||value==='2'){
    return '低'
  }
  else if(value==='3'||value==='4'||value==='5')
  {
    return '中等'
  }
  else if(value==='6'||value==='7'||value==='8'){
    return '高'
  }
  else {
    return '很高'
  }
}
