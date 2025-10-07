import org.gradle.api.Plugin
import org.gradle.api.Project

class VersionPlugin : Plugin<Project> {
    override fun apply(project: Project) {
        project.tasks.register("printVersion") {
            doLast {
                println("Project version: ${project.version}")
            }
        }
    }
}
