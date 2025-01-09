import ProjectDescription

let project = Project(
    name: "Waifu2X",
    targets: [
        .target(
            name: "Waifu2X",
            destinations: .macOS,
            product: .app,
            bundleId: "com.github.EETagent.Waifu2X",
            deploymentTargets: .macOS("12.4"),
            infoPlist: .file(path: "Waifu2X/Info.plist"),
            sources: ["Waifu2X/Sources/**", "Waifu2X/backend/realsr-ncnn-vulkan/src/realsr.cpp", "Waifu2X/backend/waifu2x-ncnn-vulkan/src/waifu2x.cpp"],
            resources: [
                .folderReference(path: "Waifu2X/backend/waifu2x-ncnn-vulkan/models_waifu2x"),
                .folderReference(path: "Waifu2X/backend/realsr-ncnn-vulkan/models_realsr"),
                "Waifu2X/Resources/**",

            ],
            scripts: Environment.bundle.getBoolean(default: false)  ?  [
                .post(
                    script: """
                    cd "${BUILT_PRODUCTS_DIR}"
                    rm -rf "Waifu2X.zip"
                    zip -r "Waifu2X.zip" "Waifu2X.app"
                    """,
                    name: "ZIP",
                    outputPaths: ["Waifu2X.zip"]
                ),
                .post(
                    script: """
                    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
                    cd "${BUILT_PRODUCTS_DIR}"
                    rm -rf "Waifu2X.dmg"
                    create-dmg \\
                    --volname Waifu2X \\
                    --background "${SRCROOT}/Waifu2X/dmg/dmg-background.tiff" \
                    --window-pos 200 120 \\
                    --window-size 660 420 \\
                    --text-size 12 \\
                    --icon-size 160 \\
                    --icon Waifu2X.app 180 170 \\
                    --app-drop-link 480 170 \
                    Waifu2X.dmg \
                    Waifu2X.app
                    """,
                    name: "DMG",
                    outputPaths: ["Waifu2X.dmg"]
                ),
            ] : [],
            dependencies: [
                .xcframework(path: "Waifu2X/contrib/ncnn.xcframework" ),
                .xcframework(path: "Waifu2X/contrib/glslang.xcframework" ),
                .xcframework(path: "Waifu2X/contrib/openmp.xcframework" ),

                .xcframework(path: "Waifu2X/contrib/MoltenVK.xcframework" ),
                .framework(path: "Waifu2X/contrib/vulkan.framework"),
                
                .target(name: "waifu2x-ncnn-vulkan"),
                .target(name: "realsr-ncnn-vulkan"),
                //.target(name: "waifu2x-ncnn-vulkan", status: LinkingStatus.none),
                //.target(name: "realsr-ncnn-vulkan", status: LinkingStatus.none),
            ],
            settings: .settings(
                base: [
                    "HEADER_SEARCH_PATHS": ["$(SRCROOT)/Waifu2X/contrib/vulkan/include"]
                ]
            )
        ),
        .target(
            name: "waifu2x-ncnn-vulkan",
            destinations: .macOS,
            product: .staticFramework,
            bundleId: "com.github.EETagent.waifu2x-ncnn-vulkan",
            deploymentTargets: .macOS("12.4"),
            infoPlist: .default,
            headers: .headers(
                public: ["Waifu2X/backend/waifu2x-ncnn-vulkan/src/waifu2x.h", "Waifu2X/backend/waifu2x-ncnn-vulkan/src/stb_image.h", "Waifu2X/backend/waifu2x-ncnn-vulkan/src/stb_image_write.h",  "Waifu2X/backend/waifu2x-ncnn-vulkan/src/filesystem_utils.h"]
            ),
            scripts: [
                .pre(
                    script: """
                    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
                    cp Waifu2X/backend/CMakeLists.waifu2x.txt Waifu2X/backend/waifu2x-ncnn-vulkan/src/CMakeLists.txt
                    cd Waifu2X/backend/waifu2x-ncnn-vulkan/src
                    cmake .
                    make generate-spirv 
                    """,
                    name: "ConfigureCMake"
                ),
                .pre(
                    script: """
                    if [ -d "Waifu2X/backend/waifu2x-ncnn-vulkan/models" ]; then
                        mv Waifu2X/backend/waifu2x-ncnn-vulkan/models Waifu2X/backend/waifu2x-ncnn-vulkan/models_waifu2x
                    fi
                    """, name: "Models"
                ),
                .pre(
                    script: """
                    sed -i '' $'s/#include "net.h"/#include <ncnn\\/ncnn\\/net.h>/g\ns/#include "gpu.h"/#include <ncnn\\/ncnn\\/gpu.h>/g\ns/#include "layer.h"/#include <ncnn\\/ncnn\\/layer.h>/g' Waifu2X/backend/waifu2x-ncnn-vulkan/src/waifu2x.h
                    """, name: "Ncnn"
                )
            ]
        ),
        .target(
            name: "realsr-ncnn-vulkan",
            destinations: .macOS,
            product: .staticFramework,
            bundleId: "com.github.EETagent.realsr-ncnn-vulkan",
            deploymentTargets: .macOS("12.4"),
            infoPlist: .default,
            headers: .headers(
                public: ["Waifu2X/backend/realsr-ncnn-vulkan/src/realsr.h"]
            ),
            scripts: [
                .pre(
                    script: """
                    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
                    cp Waifu2X/backend/CMakeLists.realsr.txt Waifu2X/backend/realsr-ncnn-vulkan/src/CMakeLists.txt
                    cd Waifu2X/backend/realsr-ncnn-vulkan/src
                    cmake .
                    make generate-spirv 
                    """,
                    name: "ConfigureCMake"
                ),
                .pre(
                    script: """
                    if [ -d "Waifu2X/backend/realsr-ncnn-vulkan/models" ]; then
                        mv Waifu2X/backend/realsr-ncnn-vulkan/models Waifu2X/backend/realsr-ncnn-vulkan/models_realsr
                    fi
                    """, name: "Models"
                ),
                .pre(
                    script: """
                    sed -i '' $'s/#include "net.h"/#include <ncnn\\/ncnn\\/net.h>/g\ns/#include "gpu.h"/#include <ncnn\\/ncnn\\/gpu.h>/g\ns/#include "layer.h"/#include <ncnn\\/ncnn\\/layer.h>/g' Waifu2X/backend/realsr-ncnn-vulkan/src/realsr.h
                    """, name: "Ncnn"
                )
            ]
        )
    ]
)
