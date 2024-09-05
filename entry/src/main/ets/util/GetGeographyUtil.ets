import http from '@ohos.net.http';
import {foregeography} from '../viewmodel/foregeography'
import {currentgeography} from '../viewmodel/currentgeography'

export class GetGeographyUtil{
  getgeography(value:string){
    return new Promise<foregeography>((resolve, reject) => {
      let request = http.createHttp();
   //付费     let url = `https://geoapi.qweather.com/v2/city/lookup?location=${value}&key=1a2c5828ae944058a06aa1f51cd10686`
      let url = `https://geoapi.qweather.com/v2/city/lookup?location=${value}&key=1a2c5828ae944058a06aa1f51cd10686`

      request.request(url,{method:http.RequestMethod.GET})
        .then((data) => {
          if (data.responseCode === 200) {
            console.log('请求没有问题');
            console.log('地理结果为：'+data.result.toString());
            resolve(JSON.parse(data.result.toString()));
          } else {
            reject(new Error(`请求失败，状态码: ${data.responseCode}`))
          }
        })
        .catch((err:string) => {
          console.log(err);
          reject(new Error(err));
        });
    });

  }

  //获取当前城市信息
  getcurrentgeography(){
    return new Promise<currentgeography>((resolve, reject) => {
      let request = http.createHttp();
      let url = 'https://restapi.amap.com/v3/ip?output=json&key=15d66c62b54ef8e7e48affe20b7a7dd1'

      request.request(url,{method:http.RequestMethod.GET})
        .then((data) => {
          if (data.responseCode === 200) {
            console.log('请求没有问题');
            console.log('当前城市信息为：'+data.result.toString());
            resolve(JSON.parse(data.result.toString()));
          } else {
            reject(new Error(`请求失败，状态码: ${data.responseCode}`))
          }
        })
        .catch((err:string) => {
          console.log(err);
          reject(new Error(err));
        });
    });
  }

}
