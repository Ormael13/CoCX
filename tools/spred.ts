/*
 * Created by aimozg on 27.07.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>

type Dict<T> = { [index: string]: T };

namespace spred {
	const basedir  = '../';
	const h_canvas = document.createElement('canvas');

	function inCanvas<T>(width: number, height: number,
	                     code: (ctx2d: CanvasRenderingContext2D) => T): T {
		h_canvas.width  = width;
		h_canvas.height = height;
		return code(h_canvas.getContext('2d'));
	}

	function splitImage(width: number, height: number, img: ImageBitmap, positions: Dict<[number, number]>): Promise<Dict<ImageBitmap>> {
		let rslt = {} as Dict<ImageBitmap>;
		return Promise.all(
			Object.keys(positions)
			      .map(key => {
				      let [x, y] = positions[key];
				      return inCanvas(width, height, ctx2d => {
					      ctx2d.drawImage(img, x, y, width, height, 0, 0, width, height);
					      return createImageBitmap(ctx2d.getImageData(0, 0, width, height))
						      .then(ib => rslt[key] = ib);
				      });
			      })).then(() => rslt);
	}

	class Spritesheet {
		public cellwidth: number;
		public cellheight: number;
		public rows: string[][];
		public img: HTMLImageElement;
		public sprites: Dict<ImageBitmap> = {};

		public isLoaded(): boolean {
			return this.img != null;
		}

		public readonly whenLoaded: Promise<Spritesheet>;

		constructor(modeldir: string, src: Element) {
			let x           = $(src);
			this.cellwidth  = +x.attr('cellwidth');
			this.cellheight = +x.attr('cellheight');

			let positions = {} as Dict<[number, number]>;
			x.children("row").each((i, row) => {
				let names = row.textContent.split(',');
				for (let j = 0; j < names.length; j++) {
					if (names[j]) positions[names[j]] = [this.cellwidth * j, this.cellheight * i];
				}
			});

			this.whenLoaded = new Promise<Spritesheet>((resolve, reject) => {
				let img    = document.createElement('img');
				img.onload = (e) => {
					createImageBitmap(img)
						.then(imgbmp =>
							splitImage(this.cellwidth, this.cellheight, imgbmp, positions)
								.then(sprites => {
									this.sprites = sprites;
									this.img     = img;
									resolve(this)
								}));
				};
				img.src    = modeldir + x.attr('file');
			});
		}
	}

	class Model {
		public name: string;
		public dir: string;
		public width: number;
		public height: number;
		public spritesheets: Spritesheet[];
		public palettes: { [index: string]: any };
		public readonly whenLoaded: Promise<Model>;

		public isLoaded(): boolean {
			return this.spritesheets.every(s => s.isLoaded());
		}

		constructor(src: XMLDocument) {
			let xmodel        = $(src).children('model');
			this.name         = xmodel.attr('name');
			this.dir          = basedir + xmodel.attr('dir');
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

			xmodel.find('spritesheet').each((i, x) => {
				let spritesheet = new Spritesheet(this.dir, x);
				this.spritesheets.push(spritesheet);
			});
			this.whenLoaded = Promise.all(this.spritesheets.map(p => p.whenLoaded))
			                         .then(() => this);
		}
	}

	export let model: Model;

	$(() => {
		let c0 = document.getElementById('canvas0') as HTMLCanvasElement;
		$.ajax(basedir + 'res/model.xml', {
			dataType: 'xml',
			/*complete: (jqXHR: JQueryXHR, textStatus: string)=>{
			
			}*/
		}).then((data: XMLDocument) => {
			model = new Model(data);
			model.whenLoaded.then((model) => {
				console.log(model);
				let list = $('#SpriteList');
				for (let ss of model.spritesheets) {
					for (let sname in ss.sprites) {
						inCanvas(ss.cellwidth, ss.cellheight, ctx2d => {
							ctx2d.drawImage(ss.sprites[sname], 0, 0);
							h_canvas.toBlob(blob => {
								let image = $('<img>').attr('src', URL.createObjectURL(blob))
								                      .attr('style', 'width:64px;height:64px');
								list.append(
									$('<li>')
										.addClass('list-group-item')
										.append(sname, image)
								)
							})
						});
					}
				}

			})
		});
	});
}