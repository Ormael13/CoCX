/*
 * Created by aimozg on 27.07.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>

namespace spred {
	const basedir = '../';

	class Spritesheet {
		public cellwidth:number;
		public cellheight:number;
		public rows:string[][];
		public img:HTMLImageElement;
		public isLoaded():boolean {
			return this.img!=null;
		}
		
		constructor(modeldir:string,src:Element){
			let img = document.createElement('img');
			img.onload = (e)=>{
				this.img = img;
			};
			img.src = modeldir+src.getAttribute('file');
			console.log(src);
			console.log(img);
		}
	}
	
	class Model {
		public name: string;
		public dir: string;
		public width: number;
		public height: number;
		public spritesheets: Spritesheet[];
		public palettes: { [index: string]: any };
		
		public isLoaded():boolean {
			return this.spritesheets.every(s=>s.isLoaded());
		}
		
		constructor(src: XMLDocument) {
			let xmodel        = $(src).children('model');
			this.name         = xmodel.attr('name');
			this.dir          = basedir+xmodel.attr('dir');
			this.width        = parseInt(xmodel.attr('width'));
			this.height       = parseInt(xmodel.attr('height'));
			this.spritesheets = [];
			this.palettes     = {
				common: {}
			};
			
			//noinspection CssInvalidHtmlTagReference
			xmodel.find('palette>common>color').each((i, e) => {
				this.palettes.common[e.getAttribute('name')] = e.textContent;
			});
			xmodel.find('spritesheet').each((i,x)=>{
				this.spritesheets.push(new Spritesheet(this.dir,x));
			});
			console.log(this);
		}
	}
	
	export let model: Model;
	
	$(() => {
		let c0      = document.getElementById('canvas0') as HTMLCanvasElement;
		$.ajax(basedir + 'res/model.xml', {
			dataType: 'xml',
			/*complete: (jqXHR: JQueryXHR, textStatus: string)=>{
			
			}*/
		}).then((data: XMLDocument) => {
			model = new Model(data);
		});
	});
}