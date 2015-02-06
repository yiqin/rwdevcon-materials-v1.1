import Quick
import Nimble
import CourseCatalog

class CourseSpecs: QuickSpec {
    override func spec() {

        describe("Course Object") {
            let testStack : CoreDataStack = CoreDataStack()
            var testCourse : Course?

            beforeSuite {
                testCourse = testStack.create(Course.self)
            }

            it("should be creatable") {
                expect(testCourse).toNot(beNil())
            }

            it("should have a name") {
                expect(testCourse?.name).to(beNil())
            }
        }
    }
}
