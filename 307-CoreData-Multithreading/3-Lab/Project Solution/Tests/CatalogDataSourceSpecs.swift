import Quick
import Nimble
import Argo
import CourseCatalog

class CatalogDataSourceSpecs: QuickSpec {
    override func spec() {

        describe("importing") {

            let testImporter = CourseImporter()
            
            beforeSuite {
                let testContent = Fixtures().jsonContent(Named: "Courses.json")
                testImporter.importData(From:JSONValue.parse(testContent))
            }

            it("should have correct number of elements") {
                expect(testImporter.results.count) == 875
            }

            it("elements should have a name") {
                let course = testImporter.results.first
                expect(course?.name).toNot(beNil())
            }
        }
    }
}

struct Fixtures
{
    func jsonContent(Named fileName:String) -> NSDictionary {

        let bundle = NSBundle(identifier: "com.magicalpanda.CourseCatalogTests")
        let fileURL = bundle?.URLForResource(fileName.stringByDeletingPathExtension, withExtension: fileName.pathExtension)
        let inputStream = NSInputStream(URL: fileURL!)!
        inputStream.open()
        return NSJSONSerialization.JSONObjectWithStream(inputStream, options: nil, error: nil) as? NSDictionary ?? [:]
    }
}