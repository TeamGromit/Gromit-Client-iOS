import Foundation

struct DataResponse: Codable{
    let status: String
    let data: ResponseData
    
    struct ResponseData: Codable{
        
        let challengeld: CLong
        let title: String
        let startDate: Date
        let goal: Int
        let recruits: Int
        let currents: Int
    }
}
