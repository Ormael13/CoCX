/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
public class Compiler {
	public function Compiler() {
	}
	public function compile(x:XML):Statement {
		switch (x.nodeKind()) {
			case "element":
				return compileTag(x.localName(),x);
			case "text":
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
		throw new Error("Encountered text element");
	}
	protected function unknownTag(tag:String,x:XML):Statement {
		throw new Error("Unknown tag "+tag);
	}
	public function compileChildren(x:XML):StmtList {
		var list:StmtList = new StmtList();
		for each(var item:XML in x.children()) {
			var e:Statement = compile(item);
			if (e) list.stmts.push(e);
		}
		return list;
	}
	public function compileXMLList(x:XMLList):StmtList {
		var list:StmtList = new StmtList();
		for each(var item:XML in x) {
			var e:Statement = compile(item);
			if (e) list.stmts.push(e);
		}
		return list;
	}
	public function compileIf(x:XML):IfStmt {
		var item:XML;
		var iff:IfStmt = new IfStmt(x.@test.toString());
		for each(item in x.*) {
			switch (item.localName()) {
				case 'else':
					iff.elseBlock = compileChildren(x);
					break;
				case 'elseif':
					iff.elseBlock = compileIf(x);
					break;
				default:
					var e:Statement = compile(item);
					if (e) iff.thenBlock.push(e);
			}
		}
		return iff;
	}
	public function compileSwitch(x:XML):SwitchStmt {
		var hasval:Boolean           = x.attribute("value").length() > 0;
		var item:XML;
		var zwitch:SwitchStmt = new SwitchStmt(hasval ? x.@value.toString() : null);
		for each(var xcase:XML in x.elements("case")) {
			var hasval2:Boolean   = hasval && xcase.attribute("value").length() > 0;
			var hasval3:Boolean   = hasval && xcase.attribute("values").length() > 0;
			var hastest:Boolean   = xcase.attribute("test").length() > 0;
			var caze:CaseStmt = new CaseStmt(
					hastest ? xcase.@test.toString() : null,
					hasval3 ? xcase.@values.toString() :
							hasval2 ? xcase.@value.toString()  : null);
			caze.thenBlock = compileChildren(xcase);
			zwitch.cases.push(caze);
		}
		zwitch.defaults = compileXMLList(x.elements("default").*);
		return zwitch;
	}
}
}
