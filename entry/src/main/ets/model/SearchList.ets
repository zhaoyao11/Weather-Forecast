import {geography} from '../viewmodel/geography'
import { edgeWidths } from '@ohos.arkui.node'
import {foreNowWeather} from '../viewmodel/foreNowWeather'
import {getWeatherUtil} from '../util/GetWeatherUtil'
import dataPreferences from '@ohos.data.preferences'
import promptAction from '@ohos.promptAction';

@Component
export struct searchlistItem{
  @StorageLink("location_code") location_code:string = '' //城市ID码
  @StorageLink("SelectedCitys") SelectedCitys:string[]=[] //已添加城市的城市代码

  CurrentCityCity:foreNowWeather = new foreNowWeather()
  array:geography = new geography()

 @State citytemp:string = ''
 @State citytext:string = ''
  @State feeltemp:string = ''
  @State winddir:string = ''

 @State newAddCity:string = ''

  aboutToAppear(): void {
    console.log('当前城市代码：'+this.array.id)
    new getWeatherUtil().getNowWeather(this.array.id).then((data)=>{
      //console.log('当前城市温度：' + data.now.temp)
      //console.log('当前城市天气：' + data.now.text)
      this.citytemp = data.now.temp
      this.citytext = data.now.text
      this.feeltemp = data.now.feelsLike
      this.winddir = data.now.windDir
    })
 //   console.log('当前城市代码：'+this.array.id)
   // console.log('当前城市温度：'+this.citytemp)
   // console.log('当前城市天气：'+this.citytext)
  }

    build() {
      Column() {
        Row() {
          Text(this.array.name)
            .fontSize(26)
            .margin({ left: 10 })

          Text(this.array.adm1 + '  ' + this.array.adm2 + '市' + '  ' + this.array.country)//所属省
            .fontSize(20)
            .margin({ left: 10 })
            .layoutWeight(1)
        }
        .margin({ top: 10 })
        .width('100%')

        //该城市的简略天气描述
        Row() {
          Text(this.citytext + '   ' + this.citytemp + '°')
            .fontSize(26)
            .layoutWeight(1)
            .margin({left:10})
        }
        .width('100%')
        .layoutWeight(1)

        Row(){
          Text('体感温度：'+this.feeltemp+'°' + '   '+this.winddir)
            .fontSize(26)
            .layoutWeight(1)
            .margin({left:10})

        }
        .width('100%')
        .layoutWeight(1)


      }
      .borderWidth(edgeWidths(1))
      .borderRadius(10)
      .height(180)
      .width('100%')
      .layoutWeight(1)
      .margin({top:10})
      .onClick(() => {
        this.location_code = this.array.id
        console.log('该城市代码为：' + this.location_code)
        if(this.SelectedCitys.includes(this.location_code)){
          AlertDialog.show({
            message:'你已经添加过这个地区了',
            alignment:DialogAlignment.Center,
            autoCancel:true,
            primaryButton:{
              value:'确定',
              fontColor:Color.Blue,
              action:()=>{

              }
            }
          })
        }
        else {
          AlertDialog.show({
            title: '添加城市天气',
            message: '是否添加该地区天气？',
            autoCancel: true,
            alignment: DialogAlignment.Center,
            primaryButton: {
              value: '添加',
              fontColor: Color.Red,
              action: () => {
                this.SelectedCitys.push(this.location_code)
                console.log('确认添加')
                console.log('添加后的数组长度为：' + this.SelectedCitys.length)

                //数据持久化
                dataPreferences.getPreferences(getContext(this),"citys",(err,preferences)=>{
                  preferences.put("citys", this.SelectedCitys,(err)=>{
                    if(err){
                      console.log('保存到首选项出错')
                      return
                    }
                  })
                  //刷新数据
                  preferences.flush((err)=>{
                    if(err){
                      console.log('刷新首选项出错')
                      return
                    }
                  })
                  promptAction.showToast({message:"保存成功",duration:100});
                })

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
      })

    }

}