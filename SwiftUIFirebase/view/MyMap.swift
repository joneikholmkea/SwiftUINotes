//
//  MyMap.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 02/03/2023.
//

import SwiftUI
import MapKit

struct MyMap: UIViewRepresentable {
    var region:MKCoordinateRegion
    var myAnnotations = MyAnnotations()
    var map:MKMapView
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    init(region:MKCoordinateRegion){
        self.region = region
        let v = MKMapView(frame: .zero)
        v.region = region
        v.addAnnotations(myAnnotations.annotations)
        map = v
    }
    
    func makeUIView(context: Context) -> MKMapView {
        map.delegate = context.coordinator
       return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Add a long press gesture recognizer to the map view
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(context.coordinator.handleLongPress(_:)))
        map.addGestureRecognizer(longPressRecognizer)
    }
    
    // Set up a coordinator to handle the gesture recognizer and pass the coordinates back to the SwiftUI view
        func makeCoordinator() -> MyMap.Coordinator {
            Coordinator(self)
        }
    
    class Coordinator: NSObject, MKMapViewDelegate {
            var parent: MyMap
            init(_ parent: MyMap) {
                self.parent = parent
            }
            // Handle the long press gesture
            @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
                if gestureRecognizer.state == .ended {
                    let location = gestureRecognizer.location(in: gestureRecognizer.view)
                    let coordinate = parent.map.convert(location, toCoordinateFrom: parent.map)
                    let loc = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    fService.currentLocation = loc // for later use
                    fService.isConfirmShowing = true
                    print("Long press at: \(coordinate.latitude), \(coordinate.longitude)")
                }
            }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            if let anno = annotation as? MyCustomAnnotation{
                print("some annotation clicekd \(anno.note)")
                fService.mapTappedNote = anno.note
                parent.mode.wrappedValue.dismiss()
            }
        }
        }
}

class MyAnnotations{
    var annotations = [MKPointAnnotation]()
    init(){
        for note in fService.notes {
            if let loc = note.location{
                let annotation = MyCustomAnnotation(note: note)
                annotation.coordinate = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
                annotations.append(annotation)
            }
        }
    }
}

class MyCustomAnnotation: MKPointAnnotation{
    var note:Note
    init(note: Note) {
        self.note = note
    }
}
