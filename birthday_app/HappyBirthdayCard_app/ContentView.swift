//
//  ContentView.swift
//  kousin_happybirthday_app
//
//  Created by kaito on 2023/10/11.
//

import SwiftUI
import UIKit
import Photos

struct ContentView: View {
    @State var card_list = [1,2,3,4,5]
    @State var index = 1
    
    @State var my_name = ""
    
    @State private var selectedImage: Image?
    @State private var showImagePicker: Bool = false
    
    //画面遷移
    @State private var showShould_result_View = false
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: result_View(my_name: my_name, selectedImage: selectedImage), isActive: $showShould_result_View){
                    EmptyView()
                }
                Color.brown.ignoresSafeArea()
                VStack {
                    Text("Birthday Card").font(.system(size: 50)).fontWeight(.light)
                    Spacer()
                    //自分の画
                    Button(action: {
                        self.showImagePicker.toggle()
                    }){
                        Text("画像を選択").font(.title).fontWeight(.medium).frame(width: 200, height: 40).background(Color.mint).foregroundColor(Color.black).cornerRadius(10)
                    }
                    selectedImage?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(200)
                        .padding()
                    //自分の名前
                    Text("自分の名前").font(.largeTitle).fontWeight(.regular)
                    TextField("タップして自分の名前を入力して下さい", text: $my_name).textFieldStyle(.roundedBorder)
                    Spacer()
                    Button(action: {
                        showShould_result_View = true
                    }){
                        Text("作成").font(.largeTitle).fontWeight(.bold).frame(width: 100, height: 100).background(Color.green).foregroundColor(Color.white).cornerRadius(100)
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: self.$selectedImage)
                }
            }
            //キーボードを閉じる
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("閉じる") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
    }
}

struct ImagePicker: View {
    @Binding var selectedImage: Image?
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ImagePickerRepresentable(selectedImage: $selectedImage, presentationMode: presentationMode)
    }
}

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    var presentationMode: Binding<PresentationMode>

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // 更新が必要な場合の処理を追加
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerRepresentable

        init(_ parent: ImagePickerRepresentable) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ContentView()
}
