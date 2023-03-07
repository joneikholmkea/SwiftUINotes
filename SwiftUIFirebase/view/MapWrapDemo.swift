//
//  MapWrapDemo.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 07/03/2023.
//

import SwiftUI

struct MapWrapDemo: View {
    var theMap:MyMap
    init(){
        theMap = MyMap(region: myRegion.region)
    }
    var body: some View {
        theMap
    }
}

struct MapWrapDemo_Previews: PreviewProvider {
    static var previews: some View {
        MapWrapDemo()
    }
}
