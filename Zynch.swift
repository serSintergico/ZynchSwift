import Foundation

// Función para hacer la solicitud GET a la API
func fetchData(from url: String) {
    guard let url = URL(string: url) else {
        print("URL inválida")
        return
    }
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error en la solicitud: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error: No se recibió una respuesta HTTP válida")
            return
        }
        
        if httpResponse.statusCode == 200 {
            guard let data = data else {
                print("Error: No se recibieron datos de la API")
                return
            }
            
            guard let responseData = String(data: data, encoding: .utf8) else {
                print("Error al convertir los datos a texto")
                return
            }
            
            print("Respuesta de la API: \(responseData)")
        } else {
            print("Error: Código de estado HTTP \(httpResponse.statusCode)")
        }
    }
    
    task.resume()
}

// Función para obtener los datos del usuario
func getUserData() {
    print("Seleccione qué dato desea ingresar:")
    print("1. Nombre completo")
    print("2. Teléfono")
    print("3. Email")
    
    guard let option = readLine(), let choice = Int(option) else {
        print("Opción inválida")
        return
    }
    
    var query = ""
    
    switch choice {
    case 1:
        print("Ingrese el nombre completo:")
        if let fullName = readLine() {
            query = "fullName=\(fullName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
    case 2:
        print("Ingrese el teléfono:")
        if let phone = readLine() {
            query = "phone=\(phone)"
        }
    case 3:
        print("Ingrese el email:")
        if let email = readLine() {
            query = "email=\(email)"
        }
    default:
        print("Opción inválida")
        return
    }
    
    let apiUrl = "http://localhost:3000/api/encontrar-usuario?\(query)"
    fetchData(from: apiUrl)
}

// Llamada a la función para obtener los datos del usuario
getUserData()
