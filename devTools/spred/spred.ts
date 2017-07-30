/*
 * Created by aimozg on 27.07.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>

type Dict<T> = { [index: string]: T };
type TDrawable = HTMLImageElement | HTMLCanvasElement | HTMLVideoElement | ImageBitmap;

namespace spred {
	const basedir = window['spred_basedir'] || '../../';
	
	/*
	function mkimg(colors: string[][]): HTMLCanvasElement {
		const hex     = {a: 10, b: 11, c: 12, d: 13, e: 14, f: 15, A: 10, B: 11, C: 12, D: 13, E: 14, F: 15};
		let canvas    = document.createElement('canvas');
		let w         = colors[0].length;
		let h         = colors.length;
		canvas.width  = w;
		canvas.height = h;
		let c2d       = canvas.getContext('2d');
		let id        = c2d.getImageData(0, 0, w, h);
		let px        = id.data;
		let i         = 0;
		for (let y = 0; y < h; y++) {
			for (let x = 0; x < w; x++) {
				let rgb    = colors[y][x];
				let r: any = rgb.charAt(0), g: any = rgb.charAt(1), b: any = rgb.charAt(2);
				r          = hex[r] || +r;
				g          = hex[g] || +g;
				b          = hex[b] || +b;
				px[i++]    = (r << 4) | r;
				px[i++]    = (g << 4) | g;
				px[i++]    = (b << 4) | b;
				px[i++]    = 0xff;
			}
		}
		c2d.putImageData(id, 0, 0);
		return canvas;
	}
	*/
	
	export function $new(selector: string = 'div', ...content: (string | JQuery | Element)[]): JQuery {
		let ss      = selector.split(/\./);
		let tagName = ss[0] || 'div';
		let d       = document.createElement(tagName);
		d.className = ss.slice(1).join(' ');
		if (tagName == 'button') (d as HTMLButtonElement).type = 'button';
		if (tagName == 'a') (d as HTMLAnchorElement).href = 'javascript:void(0)';
		return $(d).append(content);
	}
	
	export function newCanvas(width: number, height: number,
							  code: (ctx2d: CanvasRenderingContext2D) => any = () => {}): HTMLCanvasElement {
		let canvas    = document.createElement('canvas');
		canvas.width  = width;
		canvas.height = height;
		code(canvas.getContext('2d'));
		return canvas;
	}
	
	export class Composite {
		public ui: JQuery;
		
		private readonly _layers: string[] = [];
		public readonly canvas: HTMLCanvasElement;
		
		public get layers(): string[] {
			return this.model.layerNames.filter(ln => this._layers.indexOf(ln) >= 0);
		}
		
		public set layers(value: string[]) {
			this._layers.splice(0, this._layers.length);
			this._layers.push(...value.filter(l => l in this.model.layers));
		}
		
		public redraw(x: number = 0,
					  y: number = 0,
					  w: number = this.model.width,
					  h: number = this.model.height) {
			let ctx2d                   = this.canvas.getContext('2d');
			ctx2d.imageSmoothingEnabled = false;
			let z                       = this.zoom;
			ctx2d.clearRect(x * z, y * z, w * z, h * z);
			for (let a = this.model.layerNames, i = a.length - 1; i >= 0; i--) {
				let lname = a[i];
				if (this._layers.indexOf(lname) >= 0) ctx2d.drawImage(this.model.layers[lname].canvas, x, y, w, h, x * z, y * z, w * z, h * z);
			}
		}
		
		public hideAll(name: string) {
			this._layers.splice(0, this._layers.length);
		}
		
		public isVisible(layerName: string) {
			return this._layers.indexOf(layerName) >= 0;
		}
		
		public setVisible(layerName: string, visibility: Boolean) {
			let i = this._layers.indexOf(layerName);
			if (visibility && i == -1) this._layers.push(layerName);
			else if (!visibility && i >= 0) this._layers.splice(i, 1);
		}
		
		public get zoom(): number {
			return this.canvas.width / this.model.width;
		}
		
		public set zoom(value: number) {
			value              = Math.max(1, value | 0);
			this.canvas.width  = this.model.width * value;
			this.canvas.height = this.model.height * value;
			this.redraw();
		}
		
		constructor(public readonly model: Model,
					visibleNames: string[] = [],
					zoom: number           = 1) {
			this.canvas = newCanvas(model.width * zoom, model.height * zoom);
			this.canvas.setAttribute('focusable', 'true');
			this.layers = visibleNames.slice(0);
			this.redraw();
		}
	}
	
	export class Layer {
		public ui: JQuery;
		public readonly canvas: HTMLCanvasElement;
		public readonly ctx2d: CanvasRenderingContext2D;
		
		updateUI(){
			let c2d = (this.ui.find('canvas')[0] as HTMLCanvasElement).getContext('2d');
			c2d.drawImage(this.canvas, 0, 0, 32, 32);
		}
		
		constructor(public readonly name: string,
					public readonly width: number,
					public readonly height: number,
					src: TDrawable,
					srcX: number,
					srcY: number) {
			this.canvas        = document.createElement('canvas');
			this.canvas.width  = width;
			this.canvas.height = height;
			this.ctx2d         = this.canvas.getContext('2d');
			this.ctx2d.drawImage(src, srcX, srcY, width, height, 0, 0, width, height);
		}
	}
	
	function url2img(src:string):Promise<HTMLImageElement> {
		return new Promise<HTMLImageElement>((resolve,reject)=>{
			let img    = document.createElement('img');
			img.onload = (e) => {
				resolve(img);
			};
			img.src    = src;
		});
	}
	
	export class Spritesheet {
		public cellwidth: number;
		public cellheight: number;
		public rows: string[][];
		public img: HTMLImageElement;
		public sprites: Dict<Layer> = {};
		
		public isLoaded(): boolean {
			return this.img != null;
		}
		
		public readonly whenLoaded: Promise<Spritesheet>;
		
		constructor(modeldir: string, src: Element) {
			let x           = $(src);
			this.cellwidth  = +x.attr('cellwidth');
			this.cellheight = +x.attr('cellheight');
			this.sprites    = {};
			
			this.whenLoaded = new Promise<Spritesheet>((resolve, reject) => {
				let positions = {} as Dict<[number, number]>;
				x.children("row").each((i, row) => {
					let names = row.textContent.split(',');
					for (let j = 0; j < names.length; j++) {
						if (names[j]) positions[names[j]] = [this.cellwidth * j, this.cellheight * i];
					}
				});
				url2img(modeldir + x.attr('file')
				).then(img=>{
					Object.keys(positions)
						  .forEach(key => {
							  this.sprites[key] = new Layer(key, this.cellheight, this.cellwidth, img, positions[key][0], positions[key][1]);
						  });
					this.img = img;
					resolve(this);
				});
			});
		}
	}
	
	interface ColorKey {
		src: string;
		base: string;
		transform: string;
	}
	
	export class Model {
		public name: string;
		public dir: string;
		public width: number;
		public height: number;
		public spritesheets: Spritesheet[];
		public layers: Dict<Layer>   = {};
		public layerNames: string[]  = [];
		public palettes: { [index: string]: any };
		public readonly whenLoaded: Promise<Model>;
		public colorkeys: ColorKey[] = [];
		
		public putPixel(x: number, y: number, color: string) {
			let l = getSelLayer();
			if (!l) return;
			let ctx = l.ctx2d;
			if (!color) {
				ctx.clearRect(x, y, 1, 1);
			} else {
				ctx.fillStyle = color;
				ctx.fillRect(x, y, 1, 1);
			}
		}
		
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
			
			xmodel.find('colorkeys>key').each((i, e) => {
				this.colorkeys[e.getAttribute('src')] = {
					src      : e.getAttribute('src'),
					base     : e.getAttribute('base'),
					transform: e.getAttribute('transform') || ''
				};
			});
			
			//noinspection CssInvalidHtmlTagReference
			xmodel.find('palette>common>color').each((i, e) => {
				this.palettes.common[e.getAttribute('name')] = e.textContent;
			});
			
			xmodel.find('spritesheet').each((i, x) => {
				let spritesheet = new Spritesheet(this.dir, x);
				this.spritesheets.push(spritesheet);
			});
			
			xmodel.find('layer').each((i, x) => {
				let ln = x.getAttribute('file');
				if (this.layerNames.indexOf(ln) < 0) this.layerNames.push(ln);
			});
			this.whenLoaded =
				Promise.all(this.spritesheets.map(p => p.whenLoaded)
				).then(() => {
					for (let ss of this.spritesheets) {
						for (let sname in ss.sprites) {
							this.layers[sname] = ss.sprites[sname];
						}
					}
					return this;
				});
		}
	}
	
	export let g_model: Model;
	export let g_composites: Composite[] = [];
	export let g_sellayer: string        = '';
	export let defaultLayerList          = [
		'eyes2M', 'hair0f', 'ears0', 'face0',
		'breasts0', 'arm0f', 'legs0', 'torso0', 'arm0b'
	];
	
	export function updateCompositeLayers(composite: Composite) {
		let j = composite.ui.find('.LayerBadges').html('');
		for (let ln of composite.model.layerNames) {
			let b = $new('button.badge' +
						 (composite.isVisible(ln) ? '.badge-primary' : '.badge-default'),
				ln);
			b.click(() => {
				b.toggleClass('badge-primary');
				b.toggleClass('badge-default');
				composite.setVisible(ln, !composite.isVisible(ln));
				composite.redraw();
			});
			j.append(b, ' ');
		}
	}
	
	export function addCompositeView(layers: string[], zoom: number = 1): Composite {
		let composite = new Composite(g_model, layers, zoom);
		$('#ViewList').append(
			composite.ui = $new('.card.card-secondary.d-inline-flex',
				$new('.card-block',
					$new('h5.card-title',
						$new('button.ctrl.text-danger.pull-right', $new('span.fa.fa-close')
						).click(() => {
							removeCompositeView(composite);
						}),
						$new('button.ctrl', $new('span.fa.fa-search-plus')
						).click(() => {
							composite.zoom++;
						}),
						$new('button.ctrl', $new('span.fa.fa-search-minus')
						).click(() => {
							composite.zoom--;
						})
					),
					$new('div', $new('.canvas', composite.canvas)),
					$new('label',
						$new('span.fa.fa-caret-down'), 'Layers'
					).click(e => {
						composite.ui.find('.LayerBadges').toggleClass('collapse');
					}),
					$new('.LayerBadges.collapse')
					/*$new('textarea.col.form-control'
					).val(layers.join(', ')
					).on('input change', e => {
						composite.layers = (e.target as HTMLTextAreaElement).value.split(/, *!/);
						composite.redraw();
					})*/
				)
			)
		);
		let drawing       = false;
		let dirty         = false;
		let x0            = g_model.width, y0 = g_model.height, x1 = -1, y1 = -1;
		let color: string = null;
		
		function putPixel(cx: number, cy: number) {
			let x = (cx / composite.zoom) | 0;
			let y = (cy / composite.zoom) | 0;
			dirty = true;
			g_model.putPixel(x, y, color);
			composite.redraw(x, y, 1, 1);
			if (x < x0) x0 = x;
			if (x > x1) x1 = x;
			if (y < y0) y0 = y;
			if (y > y1) y1 = y;
		}
		
		$(composite.canvas).mousedown(e => {
			let action    = $('[name=lmb-action]:checked').val();
			let keycolors = $('#lmb-color');
			switch (action) {
				case 'nothing':
					return;
				case 'erase':
					color = null;
					break;
				case 'keycolor':
					color = keycolors.val();
					break;
			}
			drawing = true;
			putPixel(e.offsetX, e.offsetY);
		}).mousemove(e => {
			if (drawing) {
				putPixel(e.offsetX, e.offsetY);
			}
		}).on('mouseup mouseout', e => {
			drawing = false;
			if (dirty) redrawAll(x0, y0, x1 - x0 + 1, y1 - y0 + 1);
			dirty = false;
		});
		g_composites.push(composite);
		updateCompositeLayers(composite);
		return composite;
	}
	
	export function removeCompositeView(composite: Composite) {
		let i = g_composites.indexOf(composite);
		if (i < 0) return;
		g_composites.splice(i, 1);
		composite.ui.remove();
	}
	
	export function redrawAll(x: number = 0,
							  y: number = 0,
							  w: number = g_model.width,
							  h: number = g_model.height) {
		for (let obj of g_composites) {
			obj.redraw(x, y, w, h);
		}
	}
	
	export function swapLayers(a: number, b: number) {
		let l0                = g_model.layerNames[a];
		g_model.layerNames[a] = g_model.layerNames[b];
		g_model.layerNames[b] = l0;
		showLayerList(g_model);
		redrawAll();
	}
	
	function showLayerList(model: Model) {
		let list = $('#LayerList');
		for (let ln of model.layerNames) model.layers[ln].ui.detach().appendTo(list);
	}
	
	export function getSelLayer(): Layer {
		return g_model.layers[g_sellayer];
	}
	
	export function selLayer(name: string) {
		g_sellayer = name;
		$('#SelLayerName').html(name);
		$('.LayerListItem').removeClass('selected');
		let l = getSelLayer();
		if (l) l.ui.addClass('selected');
		$('#SelLayerCanvas').html('').append(l.canvas);
	}
	
	export function selLayerUp() {
		let i = g_model.layerNames.indexOf(g_sellayer);
		if (i > 0) swapLayers(i, i - 1);
	}
	
	export function selLayerDown() {
		let i = g_model.layerNames.indexOf(g_sellayer);
		if (i >= 0 && i < g_model.layerNames.length - 1) swapLayers(i, i + 1);
	}
	
	export function colormap(src:ImageData,map:[number,number][]):ImageData {
		let dst = new ImageData(src.width,src.height);
		let sarr = new Uint32Array(src.data.buffer);
		let darr = new Uint32Array(dst.data.buffer);
		for (let i=0,n=darr.length;i<n;i++) {
			darr[i] = sarr[i];
			for (let j=0,m=map.length;j<m;j++) {
				if (sarr[i] === map[j][0]) {
					darr[i] = map[j][1];
					break;
				}
			}
		}
		return dst;
	}
	
	function grabData(blob:Blob) {
		let mask = $('#ClipboardMask').val();
		let i32mask = 0;
		if (mask && mask.charAt(0) == '#' && mask.length==7) {
			i32mask = +('0x'+mask.slice(1))|0;
			//noinspection JSBitwiseOperatorUsage
			if (!(i32mask & 0xff000000)) {
				i32mask = (i32mask | 0xff000000)>>>0;
			}
		}
		url2img(URL.createObjectURL(blob)
		).then(img=>{
			switch ($("input[name=clipboard-action]:checked").val()) {
				case 'replace':
					let layer = getSelLayer();
					if (!layer) return;
					layer.ctx2d.clearRect(0,0,layer.width,layer.height);
					layer.ctx2d.drawImage(img,0,0);
					if (i32mask!=0) {
						let data = layer.ctx2d.getImageData(0,0,layer.width,layer.height);
						data = colormap(data,[[i32mask,0]]);
						layer.ctx2d.clearRect(0,0,layer.width,layer.height);
						layer.ctx2d.putImageData(data,0,0);
					}
					layer.updateUI();
					redrawAll();
					break;
			}
		});
	}
	
	$(() => {
		
		$.ajax(basedir + 'res/model.xml', {
			dataType: 'xml',
		}).then((data: XMLDocument) => {
			g_model = new Model(data);
			g_model.whenLoaded.then((model) => {
				console.log("Model = ", model);
				for (let ln of model.layerNames) {
					let layer          = model.layers[ln];
					layer.ui = $new('div.LayerListItem',
						$new('label', ln
						).click(e => selLayer(ln)),
						
						newCanvas(32, 32)
					);
					layer.updateUI();
				}
				$('#SelLayerCanvas')
					.css('min-width',model.width+'px')
					.css('min-height',model.height+'px');
				showLayerList(model);
				addCompositeView(defaultLayerList, 3);
				addCompositeView(defaultLayerList, 2);
				addCompositeView(defaultLayerList, 1);
				addCompositeView(defaultLayerList, 1);
				$('#ClipboardGrabber').on('paste',e=>{
					e.stopPropagation();
					e.preventDefault();
					let cd = (e.originalEvent as ClipboardEvent).clipboardData;
					for (let i = 0,n=cd.items.length; i<n;i++) {
						let item = cd.items[i];
						if (item.type.indexOf('image/')==0) {
							grabData(item.getAsFile());
							return;
						} else {
							console.log('skip '+item.kind+' '+item.type);
						}
					}
					alert("Please paste 1 image data or file");
				});
			})
		});
	});
}