import router from '@ohos.router';
import {fifteenlist} from '../model/FifteenList'
import { font } from '@kit.ArkUI';
import {getWeatherUtil} from '../util/GetWeatherUtil'
import {forefifteendays} from '../viewmodel/forefifteendays'
import {fifteendays} from '../viewmodel/fifteendays'


@Entry
@Component
struct Fifteen_days {

  @State current_location_code:string = '101110101'
  @State fifteendaysData:fifteendays[] = []

  @State xingqi:number =0
  @State currentmonth:number = 0
  @State currentday :number = 0
  @Provide isOverMonth:boolean = false

  @State array_days:number[] = []
  @State array_xingqi:number[] = []

  date = new Date()

  aboutToAppear():void {
    //注册字体
    font.registerFont({
      familyName: 'myfont',
      familySrc: '/fonts/iconfont.ttf'
    })

    //获取15天的天气预报
    new getWeatherUtil().getfifteendays(this.current_location_code)
      .then((data)=>{
        this.fifteendaysData = data.daily
      })

    //获得当前日期
    this.currentmonth = this.date.getMonth()+1
    this.currentday = this.date.getDate()
    this.xingqi = this.date.getDay()

    //星期数组
    for(let i =0;i<15;i++){
      this.array_xingqi.push(this.xingqi)
      if(this.xingqi==7){
        this.xingqi=1
      }
      else{
        this.xingqi++;
      }

    }
    //日期数组
    for(let i=0;i<15;i++){
      this.array_days.push(this.currentday)
      //如果到了31号
      if(this.currentday + 1 == 31){
        //存在31号
        if(this.currentmonth==1||3||5||7||8||10||12){
          this.currentday++;
        }
        //不存在31号
        else{
          this.currentday = 1
       //   this.currentmonth ++;
        }
      }
      //已经到了31号
      else if(this.currentday==31)
      {
        this.currentday=1
    //    ++this.currentmonth;
      }
      else{
        this.currentday++;
      }
    }

  }

  build() {
    Column(){
      Row(){
        Image($r('app.media.returnback'))
          .width(26)
          .margin({top:10,left:10})
      }.width('100%')
      .onClick(()=>{
        router.back()
      })

      Row(){
        Text('15天天气预报')
          .fontSize(32)
          .margin({top:20,left:10})
      }.width('100%')


      //15天天气列表
      List(){
        ForEach(this.fifteendaysData,(item:fifteendays,index:number)=>{
          ListItem(){
            fifteenlist({data:item,month:this.isOverMonth?this.currentmonth+1:this.currentmonth,date:this.array_days[index],
           day:this.array_xingqi[index]})
          }
        })
      }.listDirection(Axis.Horizontal)


    }.width('100%')
    .height('100%')


  }
}