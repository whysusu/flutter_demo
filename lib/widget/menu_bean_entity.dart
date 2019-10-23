class MenuBeanEntity {
	dynamic errors;
	MenuBeanData data;
	int code;
	bool success;

	MenuBeanEntity({this.errors, this.data, this.code, this.success});

	MenuBeanEntity.fromJson(Map<String, dynamic> json) {
		errors = json['Errors'];
		data = json['Data'] != null ? new MenuBeanData.fromJson(json['Data']) : null;
		code = json['Code'];
		success = json['Success'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Errors'] = this.errors;
		if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
		data['Code'] = this.code;
		data['Success'] = this.success;
		return data;
	}
}

class MenuBeanData {
	int navCol;
	List<ManuBeanDataNavmanu> navMenu;

	MenuBeanData({this.navCol, this.navMenu});

	MenuBeanData.fromJson(Map<String, dynamic> json) {
		navCol = json['NavCol'];
		if (json['NavMenu'] != null) {
			navMenu = new List<ManuBeanDataNavmanu>();(json['NavMenu'] as List).forEach((v) { navMenu.add(new ManuBeanDataNavmanu.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['NavCol'] = this.navCol;
		if (this.navMenu != null) {
      data['NavMenu'] =  this.navMenu.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ManuBeanDataNavmanu {
	String navName;
	String navsIcon;
	int navSort;
	int navCol;
	String navUrl;
	int navIsHot;

	ManuBeanDataNavmanu({this.navName, this.navsIcon, this.navSort, this.navCol, this.navUrl, this.navIsHot});

	ManuBeanDataNavmanu.fromJson(Map<String, dynamic> json) {
		navName = json['NavName'];
		navsIcon = json['NavsIcon'];
		navSort = json['NavSort'];
		navCol = json['NavCol'];
		navUrl = json['NavUrl'];
		navIsHot = json['NavIsHot'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['NavName'] = this.navName;
		data['NavsIcon'] = this.navsIcon;
		data['NavSort'] = this.navSort;
		data['NavCol'] = this.navCol;
		data['NavUrl'] = this.navUrl;
		data['NavIsHot'] = this.navIsHot;
		return data;
	}
}
