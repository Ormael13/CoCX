/*
 * Created by aimozg on 10.08.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>
function RGBA(i: tinycolorInstance): number {
	let rgb = i.toRgb();
	return (
			   ((rgb.a * 0xff) & 0xff) << 24
			   | (rgb.b & 0xff) << 16
			   | (rgb.g & 0xff) << 8
			   | (rgb.r & 0xff)
		   ) >>> 0;
}

function randint(n: number): number {
	return Math.floor(Math.random() * n);
}
function randel<T>(arr:T[]):T {
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

function obj2kvpairs<T>(o:Dict<T>):[string,T][] {
	let rslt:[string,T][] = [];
	for (let i=0,a=Object.keys(o),n=a.length;i<n;i++) {
		rslt[i] = [a[i],o[a[i]]];
	}
	return rslt;
}
