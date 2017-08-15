/*
 * Created by aimozg on 10.08.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>
type TDrawable = HTMLImageElement | HTMLCanvasElement | HTMLVideoElement | ImageBitmap;

function RGBA(i: tinycolorInstance): number {
	let rgb = i.toRgb();
	return (
			   ((rgb.a * 0xff) & 0xff) << 24
			   | (rgb.b & 0xff) << 16
			   | (rgb.g & 0xff) << 8
			   | (rgb.r & 0xff)
		   ) >>> 0;
}

function bound(min:number,x:number,max:number=Infinity):number {
	return min < x ? x < max ? x : max : min;
}

function randint(n: number): number {
	return Math.floor(Math.random() * n);
}

function randel<T>(arr: T[]): T {
	return arr[randint(arr.length)];
}

function $new(selector: string = 'div', ...content: (string | JQuery | Element | JQuery[] | Element[])[]): JQuery {
	let ss      = selector.split(/\./);
	let tagName = ss[0] || 'div';
	let d       = document.createElement(tagName);
	d.className = ss.slice(1).join(' ');
	if (tagName == 'button') (d as HTMLButtonElement).type = 'button';
	if (tagName == 'a') (d as HTMLAnchorElement).href = 'javascript:void(0)';
	let j = $(d);
	for (let c of content) j.append(c);
	return j;
}

type Dict<T> = { [index: string]: T };

function obj2kvpairs<T>(o: Dict<T>): [string, T][] {
	let rslt: [string, T][] = [];
	for (let i = 0, a = Object.keys(o), n = a.length; i < n; i++) {
		rslt[i] = [a[i], o[a[i]]];
	}
	return rslt;
}

function colormap(src: ImageData, map: [number, number][]): ImageData {
	let dst  = new ImageData(src.width, src.height);
	let sarr = new Uint32Array(src.data.buffer);
	let darr = new Uint32Array(dst.data.buffer);
	for (let i = 0, n = darr.length; i < n; i++) {
		darr[i] = sarr[i];
		for (let j = 0, m = map.length; j < m; j++) {
			if (sarr[i] === map[j][0]) {
				darr[i] = map[j][1];
				break;
			}
		}
	}
	return dst;
}

/*
 * Takes a rect starting from (srcdx, srcdy) of size (srcw x srch) from src
 * Scales it `scale` times.
 * Puts in onto dst starting from (dstdx, dstdy), with a dst bounds limited at (dstw x dsth)
 */
function drawImage(src: TDrawable, srcdx: number, srcdy: number, srcw: number, srch: number,
				   dst: CanvasRenderingContext2D, dstdx: number, dstdy: number, dstw: number, dsth: number,
				   scale: number) {
	let sx = srcdx, sy = srcdy, sw = srcw, sh = srch;
	let dx = dstdx, dy = dstdy;
	if (dx < 0) {
		sx -= dx;
		dx = 0;
	}
	if (dy < 0) {
		sy -= dy;
		dy = 0;
	}
	if (dx + sw > dstw) sw = dstw - dx;
	if (dy + sh > dsth) sh = dsth - dy;
	dst.drawImage(src, sx, sy, sw, sh, dx * scale, dy * scale, sw * scale, sh * scale);
}