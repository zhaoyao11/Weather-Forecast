import {card_UV} from '../model/card_UV'
import {card_humidity} from '../model/card_humidity'
import {card_paska} from '../model/card_paska'
import {card_somatosensory} from '../model/card_somatosensory'
import {currentdayweather, getWeatherUtil} from '../util/GetWeatherUtil'
import {daily}from '../viewmodel/daily'
import {NowWeather} from '../viewmodel/NowWeather'
import router from '@ohos.router';
import {foredaily} from '../viewmodel/foredaily'
import {hours} from '../viewmodel/24h'
import {list24hItem} from '../model/24hList'
import {GetGeographyUtil} from '../util/GetGeographyUtil'
import {indexcomponent} from '../viewmodel/IndexComponents'

@Component
export struct NowAreaComponent{
  location_code:string = ''
  swiper_index:number = 0
  @StorageLink("textarray") textarray:string[] = []

  @State adm1:string = ''
  @State adm2:string = ''
  @Consume city:string

  @State nowWeatherData:NowWeather =new NowWeather()
  @Consume currenttext:string

  @State curAQI:string = ''
  @StorageLink("three_days_1") three_days_1:daily = new daily()

  @State three_days_2:daily = new daily()
  @State three_days_3:daily = new daily()
  @State three_days_icon:string[] = []
  @State tempMax:string =''
  @State tempMin:string = ''
 /* @State IndexArray:indexcomponent[] = [{image_url:$r('app.media.cloth'),text:''},
    {image_url:$r('app.media.fishing'),text:'你好'},
    {image_url:$r('app.media.visiting'),text:'我不好'},
    {image_url:$r('app.media.cold'),text:''},
    {image_url:$r('app.media.car'),text:''},
    {image_url:$r('app.media.sports'),text:''},
  ]*/
  @State IndexArray:indexcomponent[] = []

  @State textArray:string[] = []

  @State firstday_text:string = ''
  @State firstday_tempMax:string =''
  @State firstday_tempMin:string =''
  currentIndex = new getWeatherUtil().getCurrentWeatherIndex(this.location_code)
  @State secondday_text:string = ''
  @State secondday_tempMax:string =''
  @State secondday_tempMin:string =''

  @State thirdday_text:string = ''
  @State thirdday_tempMax:string =''
  @State thirdday_tempMin:string =''


  //24h天气数据数组
  @State array_24hdata:hours[] = []

  aboutToAppear(): void {
    new getWeatherUtil().get_24h_Weather(this.location_code)
      .then((data)=>{
        this.array_24hdata = data.hourly
      })

    console.log('这个的swiper_index为：'+this.swiper_index)

    new getWeatherUtil().getWeather(this.location_code)
      .then((data)=>{
        this.tempMax = data.daily[0].tempMax
        this.tempMin = data.daily[0].tempMin

        this.firstday_text = data.daily[0].textDay
        this.firstday_tempMax = data.daily[0].tempMax
        this.firstday_tempMin = data.daily[0].tempMin

        this.secondday_text = data.daily[1].textDay
        this.secondday_tempMax = data.daily[1].tempMax
        this.secondday_tempMin = data.daily[1].tempMin

        this.thirdday_text = data.daily[2].textDay
        this.thirdday_tempMax = data.daily[2].tempMax
        this.thirdday_tempMin = data.daily[2].tempMin


        //this.three_days_1 = data.daily[0]
        //this.three_days_2 = data.daily[1]
        //this.three_days_3 = data.daily[2]

        //三天天气图标
        this.three_days_icon[0] = chooseImageAccordingWeather(this.firstday_text)
        this.three_days_icon[1] = chooseImageAccordingWeather(this.secondday_text)
        this.three_days_icon[2] = chooseImageAccordingWeather(this.thirdday_text)
      })

    new getWeatherUtil().getCurrentWeatherIndex(this.location_code)
      .then((data)=>{
       this.IndexArray = [{image_url:$r('app.media.cloth'),text:`${data.daily[2].category}`},
         {image_url:$r('app.media.fishing'),text:`${data.daily[3].category}钓鱼`},
         {image_url:$r('app.media.visiting'),text:`旅游指数${data.daily[5].category}`},
         {image_url:$r('app.media.cold'),text:`${data.daily[8].category}感冒`},
         {image_url:$r('app.media.car'),text:`${data.daily[1].category}洗车`},
         {image_url:$r('app.media.sports'),text:`${data.daily[0].category}运动`},
       ]
        console.log('天气指数的所有数据为：'+this.IndexArray[0].text)
        console.log('天气指数的所有数据为：'+this.IndexArray[1].text)
        console.log('天气指数的所有数据为：'+this.IndexArray[2].text)
        console.log('天气指数的所有数据为：'+this.IndexArray[3].text)
        console.log('天气指数的所有数据为：'+this.IndexArray[4].text)
        console.log('天气指数的所有数据为：'+this.IndexArray[5].text)

      })



    new getWeatherUtil().getNowWeather(this.location_code)
      .then((data)=>{
        this.nowWeatherData = data.now
        this.currenttext = data.now.text
       /* this.paska = data.now.pressure
        this.feellikes = data.now.feelsLike
        this.humidity = data.now.humidity*/

    /*    console.log('小组件的数据paska为：'+this.paska)
        console.log('小组件的数据feellikes为：'+this.feellikes)
        console.log('小组件的数据humidity为：'+this.humidity)*/

      })

    new getWeatherUtil().getNowAQI(this.location_code)
      .then((data)=>{
        this.curAQI = data.now.aqi
      })

    //获取改代码对应的地名
    new GetGeographyUtil().getgeography(this.location_code)
      .then((data)=>{
        this.adm1 = data.location[0].name
        this.adm2 = data.location[0].adm2
        this.city = this.adm1+'市'
        console.log('当前页面的地址为：'+this.city)
        console.log('主页面的地址adm1:'+this.adm1)
        console.log('主页面的地址adm2:'+this.adm2)
      })

  }

  onPageShow(): void {
    console.log('这个页面重新加载')
  }

  build() {
    Column(){
      //地点
      Row(){
        //Text('this.NowViewModel.')
        Text(`${this.adm1} ${this.adm2}`)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }

      //温度
      Text(this.nowWeatherData.temp+'°')
        .fontSize(80)
        .fontColor(Color.White)

      //最高温度和最低温度
        Text(this.nowWeatherData.text + ` 最高${this.tempMax}° 最低${this.tempMin}°`)
          .fontColor(Color.White)

      //两个胶囊按钮
      Row(){
        Row() {
          Text('\ue6b6 空气优 '+this.curAQI)
            .fontFamily('myfont')
            .width(100)
            .height(25)
            .fontColor(Color.White)
        }.width(100)
        .borderRadius(12.5)
        .backgroundColor('#82808080')
        .margin({top:15,right:10})

        Row() {
          Text('\ue73f 天气预报')
            .fontFamily('myfont')
            .width(90)
            .height(25)
            .fontColor(Color.White)
        }.width(90)
        .borderRadius(12.5)
        .backgroundColor('#82808080')
        .margin({top:15,right:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/VideoPage'})
        })

      }.width('100%')

      //最近几日天气部分
      Column(){
        //今天的天气
        Row(){
            Text('今天  '+ this.firstday_text+'         '+this.three_days_icon[0]+'       '+this.firstday_tempMin+'°'+ ' ~ ' +this.firstday_tempMax+'°')
              .fontFamily('myfont')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
        }.height(50)
        Divider()

        //明天的天气
        Row(){
          Text('明天  '+this.secondday_text+'         '+this.three_days_icon[1]+'       '+this.secondday_tempMin+'°'+ ' ~ ' +this.secondday_tempMax+'°')
            .fontFamily('myfont')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }.height(50)
      Divider()
        //后天的天气
        Row(){
          Text('后天  '+ this.thirdday_text+'         '+this.three_days_icon[2]+'       '+this.thirdday_tempMin+'°'+ ' ~ ' +this.thirdday_tempMax+'°')
            .fontFamily('myfont')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }.height(50)
        Divider()

        //查看近15日天气的按钮
        Button('查看近15日天气')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .width('90%')
          .backgroundColor('#aaaaaa')
          .onClick(()=>{
            router.pushUrl({url:'pages/fifteen_days'})
          })


      }.width('90%')
      .height(200)
      .backgroundColor('#80dddddd')
      .borderRadius(20)
      .margin({top:100})


      Column() {

        Row(){
          Text('未来24小时天气')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({top:10,left:5})
        }.width('100%')

        List() {
          ForEach(this.array_24hdata, (item: hours) => {
            list24hItem({ data_24h: item })
          })
        }.listDirection(Axis.Horizontal)
        .edgeEffect(EdgeEffect.Fade)
        .layoutWeight(1)
        .margin({top:25})
      }.margin({ top: 20 })
      .backgroundColor('#80dddddd')
      .width('90%')
      .borderRadius(15)
      .height(200)


      //小卡片部分
      Row(){
        //card_UV({uvIndex:this.uv})
        //card_humidity({humidity:this.humidity})
        card_UV({code:this.location_code})
        card_humidity({code:this.location_code})
          .margin({left:50})
      }.width('100%')

      Row(){
        card_somatosensory({code:this.location_code})
        card_paska({code:this.location_code})
          .margin({left:50})
      }.width('100%')




      Grid(){
          ForEach(this.IndexArray,(item:indexcomponent)=>{
              GridItem(){
                Column(){
                    Image(item.image_url)
                      .width(50)
                      .height(50)

                    Text(item.text)
                      .fontSize(15)
                      .fontColor(Color.Black)
                      .fontWeight(FontWeight.Bold)
                      .margin({top:15})
                }.width(90)
                .height(100)
              }
          })
      }.columnsTemplate('1fr 1fr 1fr')
      .borderRadius(30)
      .rowsTemplate('1fr 1fr')
      .width('85%')
      .height(300)
      .margin({top:30,bottom:10})
      .backgroundColor(Color.White)



    }.width('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .margin({top:90,left:20})
  }
}

export function chooseImageAccordingWeather(currentweather:string):string{
    if(currentweather ==='多云'){return '\ue616'}
    else if(currentweather.includes('雷')){return '\ue69e'}
    else if(currentweather.includes('晴')){return '\ue601'}
    else if(currentweather.includes('阴')){return '\ue66b'}
    else if(currentweather.includes('雪')){return '\ue7ac'}
    else if(currentweather=='小雨'){return '\ue6a0'}
    else if(currentweather.includes('雨')){return '\ue69f'}
    else if(currentweather=='大雨'){return '\ue69d'}
    else {
      return ''
    }
}