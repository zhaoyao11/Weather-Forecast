import http from '@ohos.net.http';
import {foredaily} from '../viewmodel/foredaily'
import {foreNowWeather} from '../viewmodel/foreNowWeather'
import {forenow} from  '../viewmodel/forenow'
import {forefifteendays} from '../viewmodel/forefifteendays'
import {fore24h} from '../viewmodel/fore24h'
import {foreindex} from '../viewmodel/foreIndex'


export class getWeatherUtil {

  getWeather(location_code:string) {
    return new Promise<foredaily>((resolve, reject) => {
      let request = http.createHttp();
    // let url = `https://devapi.qweather.com/v7/weather/3d?location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`;
    //  let url = `https://devapi.qweather.com/v7/weather/3d?location=101110101&key=1a2c5828ae944058a06aa1f51cd10686`;
      //付费订阅
      let url = `https://api.qweather.com/v7/weather/3d?location=${location_code}&key=35f2acca2e5c4d5cab83be20a357c2d9`

      request.request(url,{method:http.RequestMethod.GET})
        .then((data) => {
          if (data.responseCode === 200) {
            console.log('请求没有问题')
            console.log(data.result.toString())
            resolve(JSON.parse(data.result.toString()))
          } else {
            reject(new Error(`请求失败，状态码: ${data.responseCode}`))
          }
        })
          .catch((err:string) => {
            console.log(err)
            reject(new Error(err))
          })
    });
  }

  //获得当天的天气指数
  getCurrentWeatherIndex(location_code:string){
    return new Promise<foreindex>((resolve,reject)=>{
      let requestnow = http.createHttp()

      //免费订阅
      //    let url = `https://devapi.qweather.com/v7/weather/now?location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`
      //   let url = `https://devapi.qweather.com/v7/weather/now?location=101110101&key=1a2c5828ae944058a06aa1f51cd10686`
      //付费订阅
      let url = `https://devapi.qweather.com/v7/indices/1d?type=1,2,3,4,5,6,7,8,9,10,11,12&location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`

      requestnow.request(url,{method:http.RequestMethod
        .GET})
        .then((data)=>{
          if(data.responseCode===200){
            console.log('当前天气指数请求没有问题');
            console.log('当前天气指数请求数据：'+data.result.toString());
            resolve(JSON.parse(data.result.toString()))
          }else{
            console.log('请求有问题');
            reject(new Error(`请求失败,状态码：${data.responseCode}`))
          }
        })
        .catch((err:string)=>{
          reject(new Error(err))
        })
    })
  }


  //获得当天的实时天气
  getNowWeather(location_code:string){
  return new Promise<foreNowWeather>((resolve,reject)=>{
    let requestnow = http.createHttp()

 //免费订阅
 //    let url = `https://devapi.qweather.com/v7/weather/now?location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`
//   let url = `https://devapi.qweather.com/v7/weather/now?location=101110101&key=1a2c5828ae944058a06aa1f51cd10686`
//付费订阅
   let url = `https://api.qweather.com/v7/weather/now?location=${location_code}&key=35f2acca2e5c4d5cab83be20a357c2d9`

    requestnow.request(url,{method:http.RequestMethod
      .GET})
      .then((data)=>{
        if(data.responseCode===200){
          console.log('当前天气请求没有问题');
          console.log('当前天气请求数据：'+data.result.toString());
          resolve(JSON.parse(data.result.toString()))
        }else{
          console.log('请求有问题');
          reject(new Error(`请求失败,状态码：${data.responseCode}`))
        }
      })
      .catch((err:string)=>{
        reject(new Error(err))
      })
  })
  }

  //获得未来24小时的天气
  get_24h_Weather(location_code:string){
    return new Promise<fore24h>((resolve,reject)=>{
      let requestnow = http.createHttp()
  //    let url = `https://devapi.qweather.com/v7/weather/24h?location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`
      let url = `https://api.qweather.com/v7/weather/24h?location=${location_code}&key=35f2acca2e5c4d5cab83be20a357c2d9`

      requestnow.request(url,{method:http.RequestMethod
        .GET})
        .then((data)=>{
          if(data.responseCode===200){
            console.log('24小时请求没有问题');
            resolve(JSON.parse(decodeURIComponent(data.result.toString())))
          }else{
            console.log('请求有问题');
            reject(new Error(`请求失败,状态码：${data.responseCode}`))
          }
        })
        .catch((err:string)=>{
          reject(new Error(err))
        })
    })
  }

  //获取未来15天的天气预报
  getfifteendays(location_code:string){
    return new Promise<forefifteendays>((resolve,reject)=>{
      let requestnow = http.createHttp()

      //付费订阅
      let url = `https://api.qweather.com/v7/weather/15d?location=${location_code}&key=35f2acca2e5c4d5cab83be20a357c2d9`

      requestnow.request(url,{method:http.RequestMethod
        .GET})
        .then((data)=>{
          if(data.responseCode===200){
            console.log('15天气请求没有问题');
            console.log('15天气请求数据：'+data.result.toString());
            resolve(JSON.parse(decodeURIComponent(data.result.toString())))
          }else{
            console.log('请求有问题');
            reject(new Error(`请求失败,状态码：${data.responseCode}`))
          }
        })
        .catch((err:string)=>{
          reject(new Error(err))
        })
    })
  }





  //获得空气质量AQI
  getNowAQI(location_code:string){
    return new Promise<forenow>((resolve,reject)=>{
      let requestnow = http.createHttp()
  //    let url = `https://devapi.qweather.com/v7/air/now?location=${location_code}&key=1a2c5828ae944058a06aa1f51cd10686`
      //let url = `https://devapi.qweather.com/v7/air/now?location=101110101&key=1a2c5828ae944058a06aa1f51cd10686`
      //付费订阅
      let url = `https://api.qweather.com/v7/air/now?location=${location_code}&key=35f2acca2e5c4d5cab83be20a357c2d9`

      requestnow.request(url,{method:http.RequestMethod
        .GET})
        .then((data)=>{
          if(data.responseCode===200){
            console.log('请求没有问题');
            resolve(JSON.parse(decodeURIComponent(data.result.toString())))
          }else{
            console.log('请求有问题');
            reject(new Error(`请求失败,状态码：${data.responseCode}`))
          }
        })
        .catch((err:string)=>{
          reject(new Error(err))
        })
    })
  }

}
//当天全天天气
export let currentdayweather = new getWeatherUtil().getWeather('101110101')

//未来24h天气
//export let pre24hweather = new getWeatherUtil().get_24h_Weather()

//此刻空气质量
export  let curAirQuantity = new getWeatherUtil().getNowAQI('101110101')
//当天此刻天气
let nowweather = new getWeatherUtil().getNowWeather('101110101')
export default nowweather

