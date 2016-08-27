//
//  JobsDictionary.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class DataSeries {
    
    static var params : [String : AnyObject] = [ "seriesid"          : [""],
                                                 "startyear"         : "2015",
                                                 "endyear"           : "2015",
                                                 "catalog"           : true,
                                                 "calculations"      : true,
                                                 "annualaverage"     : true,
                                                 "registrationKey"   : Secrets.randomKey ]
    
    static let jobSeriesID = "OEUN0000000000000"
    static let lqSeriesID = "OEUS"
    static let employment = "01"
    static let annualMeanWage = "04"
    static let locationQuotient = "17"
    
    // Data Types:
    // 01	Employment
    // 04	Annual mean wage
    // 17	Location Quotient
    
    class func createSeriesIDsFromSOC(codes : [Int], withDataType type : String) -> [String : AnyObject] {
        
        // ie: OEUN000000000000013201104
        var seriesIDs : [String] = []
        for code in codes {
            seriesIDs.append(jobSeriesID + "\(code)" + type)
        }
        
        params["seriesid"] = seriesIDs
        return params
    }
    
    class func createStateSeriesIDsWith(SOCcode: String, withDataType type : String) -> [String : AnyObject] {
        
        var seriesIDs : [String] = []
        
        for code in stateCodes.keys {
            seriesIDs.append(lqSeriesID + "\(code)000000\(SOCcode)" + type)
        }
        
        params["seriesid"] = seriesIDs
        return params
    }
    
}

let majorSOCcodes : [String : String] = [
    "110000" : "Management Occupations",
    "130000" : "Business and Financial Operations",
    "150000" : "Computer and Mathematical",
    "170000" : "Architecture and Engineering",
    "190000" : "Life, Physical, and Social Science",
    "210000" : "Community and Social Service",
    "230000" : "Legal",
    "250000" : "Education, Training, and Library",
    "270000" : "Arts, Design, Entertainment, Sports, and Media",
    "290000" : "Healthcare Practitioners and Technical",
    "310000" : "Healthcare Support",
//    "330000" : "Protective Service",
    "350000" : "Food Preparation and Serving Related",
    "370000" : "Building and Grounds Cleaning and Maintenance",
//    "390000" : "Personal Care and Service",
//    "410000" : "Sales and Related Occupations",
//    "430000" : "Office and Administrative Support",
    "450000" : "Farming, Fishing, and Forestry",
    "470000" : "Construction and Extraction",
    "490000" : "Installation, Maintenance, and Repair",
    "510000" : "Production",
    "530000" : "Transportation"
]

let stateCodes : [String : String] =
    ["0100000" : "Alabama",
     "0200000" : "Alaska",
     "0400000" : "Arizona",
     "0500000" : "Arkansas",
     "0600000" : "California",
     "0800000" : "Colorado",
     "0900000" : "Connecticut",
     "1000000" : "Delaware",
     "1200000" : "Florida",
     "1300000" : "Georgia",
     "1500000" : "Hawaii",
     "1600000" : "Idaho",
     "1700000" : "Illinois",
     "1800000" : "Indiana",
     "1900000" : "Iowa",
     "2000000" : "Kansas",
     "2100000" : "Kentucky",
     "2200000" : "Louisiana",
     "2300000" : "Maine",
     "2400000" : "Maryland",
     "2500000" : "Massachusetts",
     "2600000" : "Michigan",
     "2700000" : "Minnesota",
     "2800000" : "Mississippi",
     "2900000" : "Missouri",
     "3000000" : "Montana",
     "3100000" : "Nebraska",
     "3200000" : "Nevada",
     "3300000" : "New Hampshire",
     "3400000" : "New Jersey",
     "3500000" : "New Mexico",
     "3600000" : "New York",
     "3700000" : "North Carolina",
     "3800000" : "North Dakota",
     "3900000" : "Ohio",
     "4000000" : "Oklahoma",
     "4100000" : "Oregon",
     "4200000" : "Pennsylvania",
     "4400000" : "Rhode Island",
     "4500000" : "South Carolina",
     "4600000" : "South Dakota",
     "4700000" : "Tennessee",
     "4800000" : "Texas",
     "4900000" : "Utah",
     "5000000" : "Vermont",
     "5100000" : "Virginia",
     "5300000" : "Washington",
     "5400000" : "West Virginia",
     "5500000" : "Wisconsin",
     "5600000" : "Wyoming"]


let jobsDictionary : [WhichInterestsStyle : AnyObject] =
    
    [WhichInterestsStyle.SolveProblem: [
        
        "Human Body" : [319091, 353041, 359011, 359099, 352015, 352012, 352014, 353021, 351011, 352021, 353022, 352019, 319094, 352011, 319092, 319011, 353011, 352013, 359031],
        
        "Environment" : [512092, 514081, 454021, 519083, 513091, 519082, 193092, 519081, 512031, 514021, 514032, 512099, 514122, 513099, 452091, 514071, 513011, 512091, 514051, 454023, 514035, 512093, 193093, 512021, 514061, 514191, 514022, 373011, 514193, 514111, 452021, 454011, 514072, 193011, 512011, 193091, 514052, 514034, 519071, 513021, 513092, 373013, 513093, 514011, 514012, 514023, 452092, 454022, 514041, 373012, 452099, 514062, 512022, 452093, 514031, 514033, 512041, 512023],
        
        "Transportation" : [537011, 537064, 533022, 537063, 537051, 537081, 533033, 532031, 533021, 537061, 537021, 537033, 537032, 537062, 532012, 537041, 537031, 533032, 532011, 532021, 533031],
        
        "Architecture" : [474041, 173026, 512092, 473014, 172031, 172121, 514081, 474011, 493011, 519083, 472131, 513091, 473011, 173023, 499051, 472051, 519082, 274012, 493042, 173027, 499071, 493021, 172011, 519081, 512031, 514021, 514032, 512099, 514122, 473015, 172071, 513099, 173013, 514071, 472221, 274014, 472061, 513011, 472011, 499052, 173024, 512091, 472121, 472132, 514051, 172041, 514035, 171021, 472071, 472111, 512093, 493023, 512021, 171012, 492095, 492096, 472021, 514061, 514191, 492093, 492091, 514022, 493043, 472053, 492092, 514193, 514111, 473019, 472171, 493041, 472022, 172111, 474091, 514072, 499062, 274031, 499043, 173022, 172051, 474021, 512011, 472044, 473016, 274032, 514052, 472031, 472072, 472073, 493031, 499044, 514034, 519071, 499021, 172021, 513021, 513092, 499041, 513093, 493022, 473013, 473012, 514011, 472082, 514012, 472042, 514023, 173012, 173011, 492094, 514041, 172061, 514062, 472041, 512022, 171011, 173025, 514031, 514033, 172081, 172072, 173021, 172112, 172141, 512041, 274011, 472043, 172131, 512023, 173019, 472081],
        
        "Teaching" : [254012, 151143, 251194, 193092, 259031, 151152, 252032, 151131, 253011, 254011, 252031, 151151, 151121, 193093, 152011, 252012, 254031, 193011, 151122, 254013, 193091, 151111, 252021, 254021, 252022, 252023, 152021, 151141]],
     
     WhichInterestsStyle.UnderstandProblem: [
        
        "Human Body" : [194021, 193092, 131022, 194091, 194092, 132021, 131023, 131131, 131021, 194031, 193093, 131075, 194011, 131081, 193011, 193091, 132061, 131032, 132053, 131051, 132031, 131031, 131141, 131161, 132051, 131071, 131111, 194041, 132072, 131121, 132011],
        
        "Environment" : [173026, 194021, 172031, 172121, 454021, 173023, 193092, 173027, 172011, 194091, 172071, 194092, 173013, 173024, 454023, 194031, 172041, 171021, 193093, 171012, 194011, 172111, 193011, 173022, 172051, 193091, 172021, 173012, 454022, 173011, 172061, 171011, 173025, 194041, 172081, 172072, 173021, 172112, 454029, 172141, 172131, 173019],
        
        "Transportation" : [533022, 533033, 532031, 533021, 533032, 532021, 533031],
        
        "Architecture" : [474041, 173026, 473014, 172031, 172121, 474011, 493011, 472131, 473011, 173023, 499051, 472051, 493042, 173027, 499071, 493021, 172011, 473015, 172071, 173013, 472221, 472061, 472011, 499052, 173024, 472121, 472132, 172041, 171021, 472071, 472111, 493023, 171012, 492095, 492096, 472021, 492093, 492091, 493043, 472053, 492092, 473019, 472171, 493041, 472022, 172111, 474091, 499062, 499043, 173022, 172051, 474021, 472044, 473016, 472031, 472072, 472073, 493031, 499044, 499021, 172021, 499041, 493022, 473013, 473012, 472082, 472042, 173012, 173011, 492094, 172061, 472041, 171011, 173025, 172081, 172072, 173021, 172112, 172141, 472043, 172131, 173019, 472081],
        
        "Teaching" : [194021, 151143, 193092, 151152, 271013, 151131, 194091, 194092, 271019, 151151, 151121, 194031, 193093, 271024, 271025, 152011, 194011, 271022, 271023, 193011, 151122, 193091, 151111, 271011, 271021, 271012, 152021, 151141, 194041]],
     
     WhichInterestsStyle.IdeaExpressed: [
        
        "History & Society" : [273041, 273012, 273011, 273091],
        
        "Art" : [271013, 271019, 271011, 271012],
        
        "Sports" : [272022, 272032, 272021],
        
        "Teaching" : [252032, 252031, 252012, 252021, 252022, 252023],
        
        "Health" : [211091, 211094, 211014, 211013]],
     
     
     WhichInterestsStyle.IdeasFormed: [
        
        "Law" : [232091, 231022, 231023, 231011, 231021],
        
        "History & Society" : [273041, 193092, 273012, 273011, 193093, 273091, 193011, 193091],
        
        "Teaching" : [251194],
        
        "Health" : [319091, 211091, 291181, 211094, 311011, 211014, 291128, 319094, 319092, 319011, 211013],
        
        "Leadership" : [119071, 119032, 119161, 113011, 113111, 119111, 119013, 113121, 113051, 112021, 119021, 119081, 119041, 113021, 119061, 113031, 112011, 119051]]
        
]

let allSOCCodes : [String : [String : String]] =
    ["110000" :
            ["112011" : "Advertising and Promotions Managers",
            "112021" : "Marketing Managers",
            "113011" : "Administrative Services Managers",
            "113021" : "Computer and Information Systems Managers",
            "113031" : "Financial Managers",
            "113051" : "Industrial Production Managers",
            "113111" : "Compensation and Benefits Managers",
            "113121" : "Human Resources Managers",
            "119013" : "Farmers, Ranchers, and Other Agricultural Managers",
            "119021" : "Construction Managers",
            "119032" : "Education Administrators, Elementary and Secondary School",
            "119041" : "Architectural and Engineering Managers",
            "119051" : "Food Service Managers",
            "119061" : "Funeral Service Managers",
            "119071" : "Gaming Managers",
            "119081" : "Lodging Managers",
            "119111" : "Medical and Health Services Managers",
            "119161" : "Emergency Management Directors"],
     
     "130000" :
            ["131021" : "Buyers and Purchasing Agents, Farm Products",
            "131022" : "Wholesale and Retail Buyers, Except Farm Products",
            "131023" : "Purchasing Agents, Except Wholesale, Retail, and Farm Products",
            "131031" : "Claims Adjusters, Examiners, and Investigators",
            "131032" : "Insurance Appraisers, Auto Damage",
            "131051" : "Cost Estimators",
            "131071" : "Human Resources Specialists",
            "131075" : "Labor Relations Specialists",
            "131081" : "Logisticians",
            "131111" : "Management Analysts",
            "131121" : "Meeting, Convention, and Event Planners",
            "131131" : "Fundraisers",
            "131141" : "Compensation, Benefits, and Job Analysis Specialists",
            "131161" : "Market Research Analysts and Marketing Specialists",
            "132011" : "Accountants and Auditors",
            "132021" : "Appraisers and Assessors of Real Estate",
            "132031" : "Budget Analysts",
            "132051" : "Financial Analysts",
            "132053" : "Insurance Underwriters",
            "132061" : "Financial Examiners",
            "132072" : "Loan Officers"],
     
     "150000" :
            ["151111" : "Computer and Information Research Scientists",
            "151121" : "Computer Systems Analysts",
            "151122" : "Information Security Analysts",
            "151131" : "Computer Programmers",
            "151141" : "Database Administrators",
            "151143" : "Computer Network Architects",
            "151151" : "Computer User Support Specialists",
            "151152" : "Computer Network Support Specialists",
            "152011" : "Actuaries",
            "152021" : "Mathematicians"],
        
        "170000" :
                ["171011" : "Architects, Except Landscape and Naval",
                "171012" : "Landscape Architects",
                "171021" : "Cartographers and Photogrammetrists",
                "172011" : "Aerospace Engineers",
                "172021" : "Agricultural Engineers",
                "172031" : "Biomedical Engineers",
                "172041" : "Chemical Engineers",
                "172051" : "Civil Engineers",
                "172061" : "Computer Hardware Engineers",
                "172071" : "Electrical Engineers",
                "172072" : "Electronics Engineers, Except Computer",
                "172081" : "Environmental Engineers",
                "172111" : "Health and Safety Engineers, Except Mining Safety Engineers and Inspectors",
                "172112" : "Industrial Engineers",
                "172121" : "Marine Engineers and Naval Architects",
                "172131" : "Materials Engineers",
                "172141" : "Mechanical Engineers",
                "173011" : "Architectural and Civil Drafters",
                "173012" : "Electrical and Electronics Drafters",
                "173013" : "Mechanical Drafters",
                "173019" : "Drafters, All Other",
                "173021" : "Aerospace Engineering and Operations Technicians",
                "173022" : "Civil Engineering Technicians",
                "173023" : "Electrical and Electronics Engineering Technicians",
                "173024" : "Electro-Mechanical Technicians",
                "173025" : "Environmental Engineering Technicians",
                "173026" : "Industrial Engineering Technicians",
                "173027" : "Mechanical Engineering Technicians"],
        
        "190000" :
                ["193011" : "Economists",
                "193091" : "Anthropologists and Archeologists",
                "193092" : "Geographers",
                "193093" : "Historians",
                "194011" : "Agricultural and Food Science Technicians",
                "194021" : "Biological Technicians",
                "194031" : "Chemical Technicians",
                "194041" : "Geological and Petroleum Technicians",
                "194091" : "Environmental Science and Protection Technicians, Including Health",
                "194092" : "Forensic Science Technicians"],
        
        "210000" :
                ["211013" : "Marriage and Family Therapists",
                "211014" : "Mental Health Counselors",
                "211091" : "Health Educators",
                "211094" : "Community Health Workers"],
        
        "230000" :
                ["231011" : "Lawyers",
                "231021" : "Administrative Law Judges, Adjudicators, and Hearing Officers",
                "231022" : "Arbitrators, Mediators, and Conciliators",
                "231023" : "Judges, Magistrate Judges, and Magistrates",
                "232091" : "Court Reporters"],
        
        "250000" :
                ["251194" : "Vocational Education Teachers, Postsecondary",
                "252012" : "Kindergarten Teachers, Except Special Education",
                "252021" : "Elementary School Teachers, Except Special Education",
                "252022" : "Middle School Teachers, Except Special and Career/Technical Education",
                "252023" : "Career/Technical Education Teachers, Middle School",
                "252031" : "Secondary School Teachers, Except Special and Career/Technical Education",
                "252032" : "Career/Technical Education Teachers, Secondary School",
                "253011" : "Adult Basic and Secondary Education and Literacy Teachers and Instructors",
                "254011" : "Archivists",
                "254012" : "Curators",
                "254013" : "Museum Technicians and Conservators",
                "254021" : "Librarians",
                "254031" : "Library Technicians",
                "259031" : "Instructional Coordinators"],
        
        "270000" :
                ["271011" : "Art Directors",
                "271012" : "Craft Artists",
                "271013" : "Fine Artists, Including Painters, Sculptors, and Illustrators",
                "271019" : "Artists and Related Workers, All Other",
                "271021" : "Commercial and Industrial Designers",
                "271022" : "Fashion Designers",
                "271023" : "Floral Designers",
                "271024" : "Graphic Designers",
                "271025" : "Interior Designers",
                "272021" : "Athletes and Sports Competitors",
                "272022" : "Coaches and Scouts",
                "272032" : "Choreographers",
                "273011" : "Radio and Television Announcers",
                "273012" : "Public Address System and Other Announcers",
                "273041" : "Editors",
                "273091" : "Interpreters and Translators",
                "274011" : "Audio and Video Equipment Technicians",
                "274012" : "Broadcast Technicians",
                "274014" : "Sound Engineering Technicians",
                "274031" : "Camera Operators, Television, Video, and Motion Picture",
                "274032" : "Film and Video Editors"],
        
        "290000" :
                ["291128" : "Exercise Physiologists",
                "291181" : "Audiologists"],
                
        "310000" :
                ["311011" : "Home Health Aides",
                "319011" : "Massage Therapists",
                "319091" : "Dental Assistants",
                "319092" : "Medical Assistants",
                "319094" : "Medical Transcriptionists"],
                
        "350000" :
                ["351011" : "Chefs and Head Cooks",
                "352011" : "Cooks, Fast Food",
                "352012" : "Cooks, Institution and Cafeteria",
                "352013" : "Cooks, Private Household",
                "352014" : "Cooks, Restaurant",
                "352015" : "Cooks, Short Order",
                "352019" : "Cooks, All Other",
                "352021" : "Food Preparation Workers",
                "353011" : "Bartenders",
                "353021" : "Combined Food Preparation and Serving Workers, Including Fast Food",
                "353022" : "Counter Attendants, Cafeteria, Food Concession, and Coffee Shop",
                "353041" : "Food Servers, Nonrestaurant",
                "359011" : "Dining Room and Cafeteria Attendants and Bartender Helpers",
                "359031" : "Hosts and Hostesses, Restaurant, Lounge, and Coffee Shop",
                "359099" : "Food Preparation and Serving Related Workers, All Other"],
        
        "370000" :
                ["373011" : "Landscaping and Groundskeeping Workers",
                "373012" : "Pesticide Handlers, Sprayers, and Applicators, Vegetation",
                "373013" : "Tree Trimmers and Pruners"],
                
        "450000" :
                ["452021" : "Animal Breeders",
                "452091" : "Agricultural Equipment Operators",
                "452092" : "Farmworkers and Laborers, Crop, Nursery, and Greenhouse",
                "452093" : "Farmworkers, Farm, Ranch, and Aquacultural Animals",
                "452099" : "Agricultural Workers, All Other",
                "454011" : "Forest and Conservation Workers",
                "454021" : "Fallers",
                "454022" : "Logging Equipment Operators",
                "454023" : "Log Graders and Scalers",
                "454029" : "Logging Workers, All Other"],
                
        "470000" :
                ["472011" : "Boilermakers",
                "472021" : "Brickmasons and Blockmasons",
                "472022" : "Stonemasons",
                "472031" : "Carpenters",
                "472041" : "Carpet Installers",
                "472042" : "Floor Layers, Except Carpet, Wood, and Hard Tiles",
                "472043" : "Floor Sanders and Finishers",
                "472044" : "Tile and Marble Setters",
                "472051" : "Cement Masons and Concrete Finishers",
                "472053" : "Terrazzo Workers and Finishers",
                "472061" : "Construction Laborers",
                "472071" : "Paving, Surfacing, and Tamping Equipment Operators",
                "472072" : "Pile-Driver Operators",
                "472073" : "Operating Engineers and Other Construction Equipment Operators",
                "472081" : "Drywall and Ceiling Tile Installers",
                "472082" : "Tapers",
                "472111" : "Electricians",
                "472121" : "Glaziers",
                "472131" : "Insulation Workers, Floor, Ceiling, and Wall",
                "472132" : "Insulation Workers, Mechanical",
                "472171" : "Reinforcing Iron and Rebar Workers",
                "472221" : "Structural Iron and Steel Workers",
                "473011" : "Helpers--Brickmasons, Blockmasons, Stonemasons, and Tile and Marble Setters",
                "473012" : "Helpers--Carpenters",
                "473013" : "Helpers--Electricians",
                "473014" : "Helpers--Painters, Paperhangers, Plasterers, and Stucco Masons",
                "473015" : "Helpers--Pipelayers, Plumbers, Pipefitters, and Steamfitters",
                "473016" : "Helpers--Roofers",
                "473019" : "Helpers, Construction Trades, All Other",
                "474011" : "Construction and Building Inspectors",
                "474021" : "Elevator Installers and Repairers",
                "474041" : "Hazardous Materials Removal Workers",
                "474091" : "Segmental Pavers"],
                
        "490000" :
                ["492091" : "Avionics Technicians",
                "492092" : "Electric Motor, Power Tool, and Related Repairers",
                "492093" : "Electrical and Electronics Installers and Repairers, Transportation Equipment",
                "492094" : "Electrical and Electronics Repairers, Commercial and Industrial Equipment",
                "492095" : "Electrical and Electronics Repairers, Powerhouse, Substation, and Relay",
                "492096" : "Electronic Equipment Installers and Repairers, Motor Vehicles",
                "493011" : "Aircraft Mechanics and Service Technicians",
                "493021" : "Automotive Body and Related Repairers",
                "493022" : "Automotive Glass Installers and Repairers",
                "493023" : "Automotive Service Technicians and Mechanics",
                "493031" : "Bus and Truck Mechanics and Diesel Engine Specialists",
                "493041" : "Farm Equipment Mechanics and Service Technicians",
                "493042" : "Mobile Heavy Equipment Mechanics, Except Engines",
                "493043" : "Rail Car Repairers",
                "499021" : "Heating, Air Conditioning, and Refrigeration Mechanics and Installers",
                "499041" : "Industrial Machinery Mechanics",
                "499043" : "Maintenance Workers, Machinery",
                "499044" : "Millwrights",
                "499051" : "Electrical Power-Line Installers and Repairers",
                "499052" : "Telecommunications Line Installers and Repairers",
                "499062" : "Medical Equipment Repairers",
                "499071" : "Maintenance and Repair Workers, General"],
                
        "510000" :
                ["512011" : "Aircraft Structure, Surfaces, Rigging, and Systems Assemblers",
                "512021" : "Coil Winders, Tapers, and Finishers",
                "512022" : "Electrical and Electronic Equipment Assemblers",
                "512023" : "Electromechanical Equipment Assemblers",
                "512031" : "Engine and Other Machine Assemblers",
                "512041" : "Structural Metal Fabricators and Fitters",
                "512091" : "Fiberglass Laminators and Fabricators",
                "512092" : "Team Assemblers",
                "512093" : "Timing Device Assemblers and Adjusters",
                "512099" : "Assemblers and Fabricators, All Other",
                "513011" : "Bakers",
                "513021" : "Butchers and Meat Cutters",
                "513091" : "Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders",
                "513092" : "Food Batchmakers",
                "513093" : "Food Cooking Machine Operators and Tenders",
                "513099" : "Food Processing Workers, All Other",
                "514011" : "Computer-Controlled Machine Tool Operators, Metal and Plastic",
                "514012" : "Computer Numerically Controlled Machine Tool Programmers, Metal and Plastic",
                "514021" : "Extruding and Drawing Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514022" : "Forging Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514023" : "Rolling Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514031" : "Cutting, Punching, and Press Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514032" : "Drilling and Boring Machine Tool Setters, Operators, and Tenders, Metal and Plastic",
                "514033" : "Grinding, Lapping, Polishing, and Buffing Machine Tool Setters, Operators, and Tenders, Metal and Plastic",
                "514034" : "Lathe and Turning Machine Tool Setters, Operators, and Tenders, Metal and Plastic",
                "514035" : "Milling and Planing Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514041" : "Machinists",
                "514051" : "Metal-Refining Furnace Operators and Tenders",
                "514052" : "Pourers and Casters, Metal",
                "514061" : "Model Makers, Metal and Plastic",
                "514062" : "Patternmakers, Metal and Plastic",
                "514071" : "Foundry Mold and Coremakers",
                "514072" : "Molding, Coremaking, and Casting Machine Setters, Operators, and Tenders, Metal and Plastic",
                "514081" : "Multiple Machine Tool Setters, Operators, and Tenders, Metal and Plastic",
                "514111" : "Tool and Die Makers",
                "514122" : "Welding, Soldering, and Brazing Machine Setters, Operators, and Tenders",
                "514191" : "Heat Treating Equipment Setters, Operators, and Tenders, Metal and Plastic",
                "514193" : "Plating and Coating Machine Setters, Operators, and Tenders, Metal and Plastic",
                "519071" : "Jewelers and Precious Stone and Metal Workers",
                "519081" : "Dental Laboratory Technicians",
                "519082" : "Medical Appliance Technicians",
                "519083" : "Ophthalmic Laboratory Technicians"],
                
        "530000" :
                ["532011" : "Airline Pilots, Copilots, and Flight Engineers",
                "532012" : "Commercial Pilots",
                "532021" : "Air Traffic Controllers",
                "532031" : "Flight Attendants",
                "533021" : "Bus Drivers, Transit and Intercity",
                "533022" : "Bus Drivers, School or Special Client",
                "533031" : "Driver/Sales Workers",
                "533032" : "Heavy and Tractor-Trailer Truck Drivers",
                "533033" : "Light Truck or Delivery Services Drivers",
                "537011" : "Conveyor Operators and Tenders",
                "537021" : "Crane and Tower Operators",
                "537031" : "Dredge Operators",
                "537032" : "Excavating and Loading Machine and Dragline Operators",
                "537033" : "Loading Machine Operators, Underground Mining",
                "537041" : "Hoist and Winch Operators",
                "537051" : "Industrial Truck and Tractor Operators",
                "537061" : "Cleaners of Vehicles and Equipment",
                "537062" : "Laborers and Freight, Stock, and Material Movers, Hand",
                "537063" : "Machine Feeders and Offbearers",
                "537064" : "Packers and Packagers, Hand",
                "537081" : "Refuse and Recyclable Material Collectors"]
]