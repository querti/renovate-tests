plugins {
    `kotlin-dsl`
}

repositories {
    gradlePluginPortal()
    mavenCentral()
}

dependencies {
    // These dependencies have older versions that Renovate can update
    implementation("com.fasterxml.jackson.core:jackson-databind:2.12.7")
    implementation("org.slf4j:slf4j-api:1.7.36")
    implementation("org.apache.commons:commons-lang3:3.12.0")
    
    // Gradle API
    implementation(gradleApi())
    implementation(localGroovy())
}
