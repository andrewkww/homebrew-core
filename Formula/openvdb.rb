class Openvdb < Formula
  desc "Sparse volume processing toolkit"
  homepage "https://www.openvdb.org/"
  url "https://github.com/AcademySoftwareFoundation/openvdb/archive/v7.0.0.tar.gz"
  sha256 "97bc8ae35ef7ccbf49a4e25cb73e8c2eccae6b235bac86f2150707efcd1e910d"
  license "MPL-2.0"
  revision 2
  head "https://github.com/AcademySoftwareFoundation/openvdb.git"

  bottle do
    sha256 "a52e3f045f00380b3b3a0246d36e6f084b197df696c8b229e83772bda2ed3017" => :catalina
    sha256 "b55dd56f20ba824ad2daa83d4ed41d656911e8b596e45f39d2ed953f04a3ac79" => :mojave
    sha256 "a7d3e9cc992f2699b1dea70a51dbd9333b423113a1c8ca819265bbbb0df0d3ca" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "boost"
  depends_on "c-blosc"
  depends_on "glfw"
  depends_on "ilmbase"
  depends_on "jemalloc"
  depends_on "openexr"
  depends_on "tbb"

  resource "test_file" do
    url "https://artifacts.aswf.io/io/aswf/openvdb/models/cube.vdb/1.0.0/cube.vdb-1.0.0.zip"
    sha256 "05476e84e91c0214ad7593850e6e7c28f777aa4ff0a1d88d91168a7dd050f922"
  end

  def install
    cmake_args = [
      "-DDISABLE_DEPENDENCY_VERSION_CHECKS=ON",
      "-DOPENVDB_BUILD_DOCS=ON",
    ]

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *cmake_args
      system "make", "install"
    end
  end

  test do
    resource("test_file").stage testpath
    system "#{bin}/vdb_print", "-m", "cube.vdb"
  end
end
