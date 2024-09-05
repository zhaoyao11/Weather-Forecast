import { NowAreaComponent } from '../view/NowAreaComponent'
import font from '@ohos.font'
import router from '@ohos.router';
import {NowWeather} from '../viewmodel/NowWeather'
import {daily}from '../viewmodel/daily'
import {hours} from '../viewmodel/24h'
import {fore24h} from  '../viewmodel/fore24h'
import dataPreferences from '@ohos.data.preferences'
import { GetGeographyUtil } from '../util/GetGeographyUtil';
import i18n from '@ohos.i18n';
import { getWeatherUtil } from '../util/GetWeatherUtil';
import {indexcomponent} from '../viewmodel/IndexComponents'

@Entry
@Component
struct Index {

  @Provide curAQI:string = '123'
  @Provide nowWeatherData:NowWeather = new NowWeather()
  @Provide WeatherDataHours:fore24h = new fore24h()
  @Provide hoursItem:hours = new hours()
  @Provide currenttext:string = ''
  @Provide city:string = ''
  @State currentcityName:string = ''
  @State currentcityCode:string = ''
  swiperController:SwiperController = new SwiperController()
  @State ToIndex:number = -1
   transliterator = i18n.Transliterator.getInstance('Any-Latn')
  @State currentCityPostCode:string = ''

  @StorageLink("textarray") textarray:string[] = []

  @StorageLink("three_days_1") three_days_1:daily = new daily()
  @StorageLink("location_code") location_code:string = ''
  @StorageLink("ClickIndex") ClickIndex:number = 0;
  @StorageLink("SelectedCitys") SelectedCitys:string[]=[] //已添加城市的城市代码

  @State temp:string = ''
  @State swiper_index:number = 0


  aboutToAppear():void{
    console.log('ClickIndex:'+this.ClickIndex.toString());
   // this.swiperController.changeIndex(this.ClickIndex,true);
    console.log('这个页面重新加载了')
    this.SelectedCitys.push('101110101')
    console.log('selectedcitys长度为：'+this.SelectedCitys.length)
    //注册字体
    font.registerFont({
      familyName: 'myfont',
      familySrc: '/fonts/iconfont.ttf'
    })

    dataPreferences.getPreferences(getContext(this),"citys",(err,preferences)=>{
      if(err){
        console.log("打开首选项失败");
        return
      }
      preferences.get('citys','',(err,val)=>{
        if(err){
          console.log("读取首选项出错");
        }
        this.SelectedCitys = val as string[]
        console.log('首选项中的citys是：'+val.toString())
      })
    })

    new GetGeographyUtil().getcurrentgeography()
      .then((data)=>{
        this.currentCityPostCode = data.adcode
        new GetGeographyUtil().getgeography(data.adcode)
          .then((data)=>{
            this.currentcityCode = data.location[0].id
            this.currentcityName = data.location[0].name + '市'
            console.log('当前定位城市到了：'+this.currentCityPostCode)
            console.log('当前定位城市的code源数据：'+data.location[0].id)
            console.log('当前定位城市的code：'+this.currentcityCode)
          })

      })

  }

  onPageShow(): void {
    console.log('这个页面重新显示了')
    console.log('这个页面重新显示了：ClickIndex:'+this.ClickIndex.toString());
    this.swiperController.changeIndex(this.ClickIndex,true);
  }

  build() {
    Stack() {
      if(this.currenttext.includes('雷')) {
        Image($r('app.media.storm'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('晴')) {
        Image($r('app.media.sunny'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('雪')) {
        Image($r('app.media.snowy'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext=='多云'){
        Image($r('app.media.cloudy'))
          .width('100%')
          .height('100%')
          .onClick(()=>{
            console.log('点击到了图片')
          })
      }
      else if(this.currenttext=='阴'){
        Image($r('app.media.cloudy_nosun'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('雨')){
        Image($r('app.media.rainy'))
          .width('100%')
          .height('100%')
      }

      Swiper(this.swiperController) {
        ForEach(this.SelectedCitys, (item:string) => {
          ListItem() {
            Scroll() {
              NowAreaComponent({ location_code:item})
            }.layoutWeight(1)
            .height('100%')
            .edgeEffect(EdgeEffect.Spring)
          }
        })
      }.autoPlay(false)
      .onChange((index:number)=>{
        console.log('当前swiper序号为：'+index.toString());
        new GetGeographyUtil().getgeography(this.SelectedCitys[index])
          .then((data)=>{
            this.city = data.location[0].name + '市'
           // console.log('当前index的city为：'+this.city)
           // console.log('当前index为：'+index.toString())
          })

        new getWeatherUtil().getNowWeather(this.SelectedCitys[index])
          .then((data)=>{
            this.currenttext = data.now.text
          //  console.log('当前index的天气为：'+this.currenttext)
          //  console.log('当前index的值为：'+index)
          })
      })
      .loop(false)
      .layoutWeight(1)
      .indicator(
        Indicator.dot()
          .itemWidth(10)
          .selectedItemWidth(25)
          .selectedColor(Color.White)
      )

      Row() {
        //点击获取当前位置
        Image($r('app.media.location'))
          .width(30)
          .height(30)
          .margin({right:15})
          .onClick(()=>{
            for(let i =0;i<this.SelectedCitys.length;i++){
              if(this.SelectedCitys[i]==this.currentcityCode){
                this.ToIndex = i;
              }
            }
            console.log('当前定位城市数组为'+this.SelectedCitys)
            console.log('当前定位城市的Index:'+this.ToIndex)

            if(this.currentcityName!=this.city) {
              AlertDialog.show({
                title: `当前城市定位为${this.currentcityName}`,
                message: `是否切换到${this.currentcityName}的天气？`,
                autoCancel: true,
                alignment: DialogAlignment.Center,
                primaryButton: {
                  value: '切换',
                  fontColor: Color.Red,
                  action: () => {
                    console.log('切换点上了')
                    this.city = this.currentcityName
                    this.swiperController.changeIndex(this.ToIndex,true)
                  }
                },
                secondaryButton: {
                  value: '取消',
                  action: () => {
                    console.log('取消添加')
                  }
                },
                cancel: () => {
                  console.log('添加弹窗退出')
                }
              })
            }
            else{
              AlertDialog.show({
                message:'当前地区天气为所定位地区天气',
                autoCancel:true,
                alignment:DialogAlignment.Center,
                primaryButton:{
                  value:'确定',
                  fontColor:Color.Blue,
                  action:()=>{

                  }
                }
              })
            }
          })

        Image($r('app.media.add'))
          .width(30)
          .height(30)
          .margin({ right: 15 })
          .onClick(()=>{
            console.log('点击到了加号')
            router.pushUrl({url:'pages/CityManager'},router.RouterMode.Standard,(err)=>{
              if(err){
                console.log(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`)
                return
              }
              console.info('Invoke replaceUrl succeeded.');
            })
          })
        Image($r('app.media.setting'))
          .width(30)
          .height(30)
      }.width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 20, right: 30 })

    }.height('100%')
    .width('100%')
    .alignContent(Alignment.TopStart)

  }

}