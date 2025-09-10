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

import QtQuick 2.4
import Lomiri.Components 1.3
import "./"

Item {
    id: creditsPage

    ListModel {
        id: creditsModel
        Component.onCompleted: {
            // TRANSLATORS: Name of a pearson that was important to the project + the reason why he/she was important
            creditsModel.append({ name: i18n.tr("Igor Sobociński - for substantive support"), title: i18n.tr("Huge thanks to:")})
            creditsModel.append({ name: i18n.tr("sutani127 - for substantive support"), title: i18n.tr("Huge thanks to:"), url: "https://github.com/sutani127"})
            creditsModel.append({ name: i18n.tr("Johan Guerreros - for Vulgry"), title: i18n.tr("Huge thanks to:"), url: "https://launchpad.net/~johangm90" })
            creditsModel.append({ name: i18n.tr("The UBports Foundation - for Lomiri Touch"), title: i18n.tr("Huge thanks to:"), url: "https://ubports.com/foundation/ubports-foundation" })
            creditsModel.append({ name: i18n.tr("Anne017 - French"), title: i18n.tr("Translators:"), url: "https://github.com/Anne017" })
            creditsModel.append({ name: i18n.tr("Piotr Lange - Polish"), title: i18n.tr("Translators:"), url: "https://github.com/PiotrZPL" })
        }
    }

    LomiriListView {
        id: credits

        currentIndex: -1
        model: creditsModel
        anchors.fill: parent

        section.property: "title"
        section.labelPositioning: ViewSection.InlineLabels
        section.delegate: HeaderListItem {
            title.text: section
        }

        // Required to accomodate the now playing bar being shown in landscape mode which
        // can hide a setting if not for this footer.
        footer: Item {
            width: parent.width
            height: units.gu(8)
        }

        delegate: ListItem {
            ListItemLayout {
                title.text: model.name
                ProgressionSlot {}
            }
            divider.visible: false
            onClicked: Qt.openUrlExternally(model.url)
        }
    }
}
