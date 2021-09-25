import UIKit

//GET the data with an API call from this URL and display Sunrise in the console

//https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=2021-09-08
/*
 {"results":{"sunrise":"5:53:18 AM","sunset":"6:37:14 PM","solar_noon":"12:15:16 PM","day_length":"12:43:56",
"civil_twilight_begin":"5:28:29 AM","civil_twilight_end":"7:02:03 PM","nautical_twilight_begin":"4:57:38 AM",
"nautical_twilight_end":"7:32:54 PM","astronomical_twilight_begin":"4:25:58 AM","astronomical_twilight_end":"8:04:33 PM"},
"status":"OK"}
 */

struct Response:Codable {
    let results:Info
    let status:String
}

struct Info:Codable {
    let sunrise:String
}

func getSunriseData() {
    guard let url = URL(string: "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=2021-09-08") else {
        return
    }
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        guard let data = data, error == nil else {
            return
        }
        var result:Response?
        do {
            result = try JSONDecoder().decode(Response.self, from:data)
        } catch {
            print("Error")
        }
        guard let json = result else {
            return
        }
        print("Sunrise: \(json.results.sunrise)")
    }
    task.resume()
}

//POST the following data to this API endpoint: "http://jsonplaceholder.typicode.com/posts"
/*
 "userId": 1,
 "title": "Gloria In Excelsis Deo",
 "body": "Do your Best. Have Fun. Don't stress.",
*/

func makePOSTRequest() {
    guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else {
        return
    }
    let body:[String:Any] = [
        "userId": 1,
        "title": "Gloria In Excelsis Deo",
        "body": "Do your Best. Have Fun. Don't stress.",
    ]
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    } catch {
        print("error")
    }
    let task = URLSession.shared.dataTask(with: request) {
        data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print("Success: \(response)")
        } catch {
            print("Error")
        }
    }
    task.resume()
}

/*
 Go to "https://rapidapi.com/integraatio/api/ocr-text-extractor/" and successfully use the API
 Endpoint: https://ocr-text-extractor.p.rapidapi.com/detect-text-from-image-uri
 let headers = [
     "content-type": "application/json",
     "accept": "string",
     "x-rapidapi-host": "ocr-text-extractor.p.rapidapi.com",
     "x-rapidapi-key": "23d691d2c9mshf1c69a63ce55a79p1f139cjsn58c1888ed9a6"
 ]
 let parameters = [
     "Uri": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
     "Language": "eng",
     "DetectOrientation": false,
     "Scale": false,
     "IsTable": false,
     "OcrEngine": "Version2"
 ] as [String : Any]
 
*/

func getGoogle() {
    guard let url = URL(string: "https://ocr-text-extractor.p.rapidapi.com/detect-text-from-image-uri") else {
        return
    }
    
    let header = [
        "content-type": "application/json",
        "accept": "string",
        "x-rapidapi-host": "ocr-text-extractor.p.rapidapi.com",
        "x-rapidapi-key": "23d691d2c9mshf1c69a63ce55a79p1f139cjsn58c1888ed9a6"
    ]
    
    let body = [
        "Uri": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
        "Language": "eng",
        "DetectOrientation": false,
        "Scale": false,
        "IsTable": false,
        "OcrEngine": "Version2"
    ] as [String : Any]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = header
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    } catch {
        print("Error")
    }
    
    let task = URLSession.shared.dataTask(with: request) {
        data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print("Success: \(response)")
        } catch {
            print("Error")
        }
    }
    task.resume()
}

getSunriseData()
makePOSTRequest()
getGoogle()
