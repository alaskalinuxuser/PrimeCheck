/*
 * Copyright (C) 2021-2022 Piotr Lange
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * PrimeCheck is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import "./"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'primecheck.piotrzpl'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)
    
    //property list<ContentItem> transferItemList
    //property var contentTransfer
    property string app_version: "1.1.3"

    
    property var settings: Settings {
        property string primaryColor: "#0169c9"
        property string theme: "Ambiance"
        onThemeChanged: Theme.name = "Lomiri.Components.Themes." + settings.theme
    }
    
    Component {
        id: aboutPage
        About {}
    }
    
    PageStack{
        id: pageStack

        Component.onCompleted: push(mainPage)

	    Page {
	        id: mainPage
	        visible: false
	        anchors.fill: parent
	
	        header: PageHeader {
	            id: header
	            title: i18n.tr('PrimeCheck')
	            trailingActionBar.actions: [
	                    Action {
	                        text: i18n.tr("Theme")
	                        iconName: (root.settings.theme == "Ambiance") ? "torch-on" : "torch-off"
	                        onTriggered: root.settings.theme = (root.settings.theme == "Ambiance") ? "SuruDark" : "Ambiance"
	                    },
	                    Action {
	                        text: i18n.tr("About")
	                        iconName: "help"
	                        onTriggered: pageStack.push(aboutPage)
	                    }
	                ]
	        }
	
	        TextField {
	        id: textField
	        text: ""
			inputMethodHints: Qt.ImhDigitsOnly
	        anchors {
	            topMargin: units.gu(1);
	            top: header.bottom
	            left: parent.left
	            leftMargin: units.gu(1);
	            right: parent.right
	            rightMargin: units.gu(1);
	        }
	
	        height: units.gu(8)
	        font.pixelSize: units.gu(4)
	        }
	        
	        Rectangle {
			    property alias text: label.text
			    signal clicked 
			    id: mainRec
			    radius: units.gu(1) 
			    border.width: units.gu(0.25) 
				border.color: backgroundColor
			
			    property alias color_text: label.color
			    Label {
			        id: label
			        font.pixelSize: units.gu(4)
			        font.bold: true
			        anchors.centerIn: parent
			        color: "#111"
			        text: i18n.tr("Check")
			    }
			
			    MouseArea {
			        id: mouseArea
			        anchors.fill: parent
			        onClicked: parent.clicked()
			    }
			    anchors {
		            topMargin: units.gu(15);
		            top: header.bottom
		            //left: parent.left
		            //leftMargin: units.gu(1);
		            //right: parent.right
		            //rightMargin: units.gu(1);
		        }
		        anchors.centerIn: parent
				color: "#006f6c"
				color_text : "black"
				height: parent.height / 6
				width: parent.width / 2
				onClicked: {
					if (textField.text != "") {
						python.call("fpc.isPrime", [ textField.text ], function ( result ) {
							var _isPrime = result[0];
							var _numberThatDevides = result[1];
							if (_isPrime) {
								isPrimeText.text = textField.text + i18n.tr(" is a prime number.");
								isPrimeText.color = "#00fe00";
								canBeDev.text = "";
							}
							else { 
								isPrimeText.text = textField.text + i18n.tr(" is not a prime number.");
								isPrimeText.color = "#e81e25";
								if (_numberThatDevides != 0) {
									canBeDev.text = i18n.tr("It is divisible by ") + _numberThatDevides;
								}
								else {
									canBeDev.text = "";
								}
							}
						})
					}
				}
			}
			Rectangle {
			    anchors {
			            topMargin: units.gu(5);
			            top: textField.bottom
			            left: parent.left
			            leftMargin: units.gu(1);
			            right: parent.right
			            rightMargin: units.gu(1);
			            bottom: mainRec.top
			        }
			    color: backgroundColor
			    
				Column {
					anchors {
						left: parent.left
						right: parent.right
						margins: units.gu(2)
					}
					Label {
						id: isPrimeText
						text: i18n.tr("Enter a number")
						font.pixelSize: units.gu(3)
						font.bold: true
						horizontalAlignment: Text.AlignHCenter
						width: parent.width
						//anchors.centerIn: parent
					}
					Label {
						id: canBeDev
						text: ""
						font.pixelSize: units.gu(3)
						font.bold: true
						horizontalAlignment: Text.AlignHCenter
						width: parent.width
						color: "#e81e25";
						//anchors.centerIn: parent
					}
				}
	        
	        }
	
	        Python {
	            id: python
	
	            Component.onCompleted: {
	                addImportPath(Qt.resolvedUrl('../src/'));
	            importModule_sync("fpc")
	            }
	
	            onError: {
	                console.log('python error: ' + traceback);
	            }
	        }
	    }
	}
}
