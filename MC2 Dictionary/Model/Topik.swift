//
//  Topik.swift
//  MC2 Dictionary
//
//  Created by Yosia on 19/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

let belanjaSentences: Any = [
    [
        "title": "Berapa harganya?",
        "content": [
            [
                "video": UIImage.gifImageWithURL(Bundle.main.url(forResource: "masukin nama video disini", withExtension: nil)!.absoluteString) as Any,
                "text": "Berapa"
            ],
            [
                "video": UIImage.gifImageWithURL(Bundle.main.url(forResource: "masukin nama video disini", withExtension: nil)!.absoluteString) as Any,
                "text": "harganya?"
            ]
        ]
    ],
    [
        "title": "Bisa ditawar?",
        "content": [
            [
                "video": UIImage.gifImageWithURL(Bundle.main.url(forResource: "masukin nama video disini", withExtension: nil)!.absoluteString) as Any,
                "text": "Bisa"
            ],
            [
                "video": UIImage.gifImageWithURL(Bundle.main.url(forResource: "masukin nama video disini", withExtension: nil)!.absoluteString) as Any,
                "text": "ditawar?"
            ]
        ],
    ]
]

let categoryList: [Any] = [
    [
        "title": "Belanja",
        "sentences": belanjaSentences
    ]
]

let TopikName = [
    "Abjad",
    "Angka",
    "HariBulan",
    "KataTanya",
    "Kegiatan",
    "Keluarga",
    "Kesehatan",
    "Perasaan",
    "Perkenalan",
    "RasaBuah",
    "Reaksi",
    "Warna"
]

let topikSentences: [String: [[String]]] = [
    "Abjad": [
        ["A"],
        ["B"],
        ["C"]
    ],
    "Angka": [],
    "HariBulan": [],
    "KataTanya": [],
    "Kegiatan": [],
    "Keluarga": [],
    "Kesehatan": [],
    "Perasaan": [],
    "Perkenalan": [
        ["Kamu", "Bisa", "Bahasa Isyarat"]
        ["Nama", "Kamu", "Siapa"],
        ["Kamu", "Tinggal", "Dimana"]
    ],
    "RasaBuah": [],
    "Reaksi": [],
    "Warna": []
]
