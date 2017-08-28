/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import classes.internals.Utils;

public class Compiler {
	public function Compiler() {
	}
	public function compile(x:XML):Statement {
		switch (x.nodeKind()) {
			case "element":
				return compileTag(x.localName(),x);
			case "text":
				if (Utils.trimSides(x.toString()) == '') return null;
				return compileText(x);
			default:
				return null;
		}
	}
	protected function compileTag(tag:String,x:XML):Statement {
		switch (tag) {
			case 'if':
				return compileIf(x);
			case 'switch':
				return compileSwitch(x);
			default:
				return unknownTag(tag,x);
		}
	}
	protected function compileText(x:XML):Statement{
		throw new Error("Encountered text element "+x.toString().substr(0,20));
	}
	protected function unknownTag(tag:String,x:XML):Statement {
		throw new Error("Unknown tag "+tag);
	}
	public function compileChildren(x:XML):StmtList {
		return new StmtList(compileChildrenInto(x,[]));
	}
	protected function compileChildrenInto(x:XML,stmts:/*Statement*/Array):/*Statement*/Array {
		for each(var item:XML in x.children()) {
			var e:Statement = compile(item);
			if (e) stmts.push(e);
		}
		return stmts;
	}
	public function compileXMLList(x:XMLList):StmtList {
		return new StmtList(compileXMLListInto(x,[]));
	}
	protected function compileXMLListInto(x:XMLList,stmts:/*Statement*/Array):/*Statement*/Array {
		for each(var item:XML in x) {
			var e:Statement = compile(item);
			if (e) stmts.push(e);
		}
		return stmts;
	}
	public function compileIf(x:XML):IfStmt {
		var item:XML;
		var iff:IfStmt = new IfStmt(x.@test.toString());
		for each(item in x.*) {
			switch (item.localName()) {
				case 'else':
					iff.elseBlock = compileChildren(item);
					break;
				case 'elseif':
					iff.elseBlock = compileIf(item);
					break;
				default:
					var e:Statement = compile(item);
					if (e) iff.thenBlock.push(e);
			}
		}
		return iff;
	}
	public function compileSwitch(x:XML):SwitchStmt {
		var sattrs:Object = attrMap(x);
		var hasval:Boolean           = 'value' in sattrs;
		var zwitch:SwitchStmt = new SwitchStmt(sattrs['value']);
		for each(var xcase:XML in x.elements("case")) {
			var cattrs:Object = attrMap(xcase);
			var caze:CaseStmt = new CaseStmt();
			caze.testAttr = cattrs['test'];
			caze.valueAttr = cattrs['value'];
			caze.valuesAttr = cattrs['values'];
			caze.ltAttr = cattrs['lt'];
			caze.lteAttr = cattrs['lte'];
			caze.gtAttr = cattrs['gt'];
			caze.gteAttr = cattrs['gte'];
			caze.neAttr = cattrs['ne'];
			compileChildrenInto(xcase,caze.thenBlock.stmts);
			zwitch.cases.push(caze);
		}
		compileXMLListInto(x.elements("default").*,zwitch.defaults.stmts);
		return zwitch;
	}
	public static function attrMap(x:XML):Object {
		var e:Object = {};
		for each (var k:XML in x.attributes()) {
			e[k.localName()] = k.toString();
		}
		return e;
	}
}
}
