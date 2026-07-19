// 1. First, set up the root build directory redirect
rootProject.layout.buildDirectory.value(rootProject.layout.projectDirectory.dir("../build"))

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 2. Consolidate subproject configurations into a single block
subprojects {
    // Redirect each subproject (like plugins) into the root build folder
    val newSubprojectBuildDir = rootProject.layout.buildDirectory.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    
    // Ensure the main :app evaluates first
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}   